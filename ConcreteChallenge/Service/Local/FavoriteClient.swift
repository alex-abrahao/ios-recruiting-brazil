//
//  FavoriteClient.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

fileprivate typealias MoviesDict = [Int : Movie]

final class FavoriteClient {
    
    var service: DocumentsSaverService
    
    fileprivate let fileNameIdentifier: String = "Favorites"
    
    init(service: DocumentsSaverService = DocumentsSaverService()) {
        self.service = service
    }
    
    fileprivate func fillImageURLs(movies: [Movie]) {
        movies.forEach { (movie) in
            if let posterPath = movie.posterPath {
                let route = ImageEndpoint.image(width: 500, path: posterPath)
                movie.posterURL = route.baseURL?.appendingPathComponent(route.path)
            }
            if let backdropPath = movie.backdropPath {
                let route = ImageEndpoint.image(width: 780, path: backdropPath)
                movie.backdropURL = route.baseURL?.appendingPathComponent(route.path)
            }
        }
    }
}

extension FavoriteClient: FavoriteClientProtocol {
    
    func setFavorite(movie: Movie) {
        
        // Get the previous favorites to add if necessary
        var favoritesToSave: MoviesDict
        if let previousFavorites: MoviesDict = service.get(fileName: fileNameIdentifier) {
            favoritesToSave = previousFavorites
            favoritesToSave[movie.id] = movie
        } else {
            favoritesToSave = [movie.id : movie]
        }
        
        service.save(favoritesToSave, fileName: fileNameIdentifier)
    }
    
    func removeFavorite(movie: Movie) {
        
        // Get the current favorites to remove the movie if necessary
        if var currentFavorites: MoviesDict = service.get(fileName: fileNameIdentifier) {
            currentFavorites[movie.id] = nil
            service.save(currentFavorites, fileName: fileNameIdentifier)
        }
        // Else can't remove from something nil
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        guard let currentFavorites: MoviesDict = service.get(fileName: fileNameIdentifier), let _ = currentFavorites[movie.id] else {
            return false
        }
        return true
    }
    
    func getFavoritesList() -> [Movie] {
        guard let currentFavorites: MoviesDict = service.get(fileName: fileNameIdentifier) else {
            return []
        }
        var favoritesList = Array(currentFavorites.values)
        favoritesList.sort(by: { $0.title < $1.title })
        favoritesList.forEach{ $0.isFavorite = true }
        fillImageURLs(movies: favoritesList)
        
        return favoritesList
    }
    
    func checkFavorites(on movies: [Movie]) {
        guard let currentFavorites: MoviesDict = service.get(fileName: fileNameIdentifier) else {
            return
        }
        // A movie is a favorite if it's contained in the local favorites list
        // Since movies are passed by reference, it's only necessary to set here
        movies.forEach { $0.isFavorite = (currentFavorites[$0.id] != nil) }
    }
}
