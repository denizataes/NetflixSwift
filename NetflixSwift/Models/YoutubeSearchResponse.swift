//
//  YoutubeSearchResponse.swift
//  NetflixSwift
//
//  Created by Deniz Ata Eş on 28.12.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IDVideoElement
}

struct IDVideoElement: Codable{
    let kind: String
    let videoId: String
}
