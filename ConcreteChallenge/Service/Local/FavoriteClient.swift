//
//  FavoriteClient.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class FavoriteClient {
    
    var service: DocumentsSaverService
    
    fileprivate let fileNameIdentifier: String = "Favorites"
    
    init(service: DocumentsSaverService = DocumentsSaverService()) {
        self.service = service
    }
}

extension FavoriteClient: FavoriteClientProtocol {
    
    func setFavorite(movie: Movie) {
        
        // Get the previous favorites to add if necessary
        var favoritesToSave: [Int : Movie]
        if let previousFavorites: [Int: Movie] = service.get(fileName: fileNameIdentifier) {
            favoritesToSave = previousFavorites
            favoritesToSave[movie.id] = movie
        } else {
            favoritesToSave = [movie.id : movie]
        }
        
        service.save(favoritesToSave, fileName: fileNameIdentifier)
    }
    
    func removeFavorite(movie: Movie) {
        
        // Get the current favorites to remove the movie if necessary
        if var currentFavorites: [Int: Movie] = service.get(fileName: fileNameIdentifier) {
            currentFavorites[movie.id] = nil
            service.save(currentFavorites, fileName: fileNameIdentifier)
        }
        // Else can't remove from something nil
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        guard let currentFavorites: [Int: Movie] = service.get(fileName: fileNameIdentifier), let _ = currentFavorites[movie.id] else {
            return false
        }
        return true
    }
    
    func getFavoritesList() -> [Movie] {
        guard let currentFavorites: [Int: Movie] = service.get(fileName: fileNameIdentifier) else {
            return []
        }
        let list = Array(currentFavorites.values)
        list.forEach{ $0.isFavorite = true }
        
        return list
    }
    
    func checkFavorites(on movies: [Movie]) {
        guard let currentFavorites: [Int: Movie] = service.get(fileName: fileNameIdentifier) else {
            return
        }
        // A movie is a favorite if it's contained in the local favorites list
        // Since movies are passed by reference, it's only necessary to set here
        movies.forEach { $0.isFavorite = (currentFavorites[$0.id] != nil) }
    }
}
