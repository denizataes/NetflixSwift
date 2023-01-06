//
//  DataPersistanceManager.swift
//  NetflixSwift
//
//  Created by Deniz Ata Eş on 5.01.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    static let shared = DataPersistanceManager()

    func downloadTitleWith(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate? else {
            return
        }

        let context = appDelegate!.persistentContainer.viewContext

        let item = TitleItem(context: context)

        item.original_title = model.originalTitle
        item.id = Int64(model.id!)
        item.overview = model.overview
        item.original_name = model.originalTitle
        item.poster_path = model.posterPath
        item.release_date = model.releaseDate
        item.vote_count = Int64(model.voteCount ?? 0)
        item.vote_average = Double(model.voteAverage ?? 0)
        item.media_type = ""

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }

    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate? else {
            return
        }

        let context = appDelegate!.persistentContainer.viewContext

        let request: NSFetchRequest<TitleItem>

        request = TitleItem.fetchRequest()

        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }

    }

    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate? else {
            return
        }

        let context = appDelegate!.persistentContainer.viewContext

        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
