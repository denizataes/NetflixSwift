//
//  APICaller.swift
//  NetflixSwift
//
//  Created by Deniz Ata Eş on 24.12.2022.
//

import Foundation

struct Constants{
    static let API_KEY = "066cd92637346c12593cd4a8543c8fe2"
    static let baseURL = "https://api.themoviedb.org"
    
}

enum APIError: Error{
    case failedToGetData
}


class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()

    }
    
    
    
    func getTrendingTvs(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    
    func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    func getTopRated(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&include_adult=false&include_video=false&language=tr&page=1&sort_by=popularity.desc&with_watch_monetization_types=flatrate") else {return}
        
    
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
                completion(.success(results.results))
                
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
       
        }
        task.resume()
        
    }
    
}
