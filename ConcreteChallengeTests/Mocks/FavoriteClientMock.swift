//
//  FavoriteClientMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 21/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class FavoriteClientMock: FavoriteClientProtocol {
    
    func setFavorite(movie: Movie) {
        movie.isFavorite = true
    }
    
    func removeFavorite(movie: Movie) {
        movie.isFavorite = false
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        return false
    }
    
    func getFavoritesList() -> [Movie] {
        // Favorites the first movie
        let movies = Stub.getMovieList()
        movies[0].isFavorite = true
        return movies
    }
    
    func checkFavorites(on movies: [Movie]) {
        // Favorites the first movie
        if let first = movies.first {
            first.isFavorite = true
        }
    }
}
