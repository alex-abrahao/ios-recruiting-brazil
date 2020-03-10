//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

final class Movie: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let genreIDs: [Int]
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    var isFavorite: Bool = false
    
    init(id: Int, title: String, overview: String, genreIDs: [Int], posterPath: String?, backdropPath: String?, releaseDate: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.genreIDs = genreIDs
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
    }
    
    var completePosterURL: URL? {
        return ImageEndpoint.image(width: 500, path: posterPath).completeURL
    }
    
    var completeBackdropURL: URL? {
        return ImageEndpoint.image(width: 780, path: backdropPath).completeURL
    }
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
