//
//  FavoriteClientProtocol.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol FavoriteClientProtocol {
    
    /// Set movie as favorite
    func setFavorite(movie: Movie)
    
    /// Remove movie as favorite
    func removeFavorite(movie: Movie)
    
    /// Check if a given movie was favorited
    func isMovieFavorite(_ movie: Movie) -> Bool
    
    /**
     Get a list of the movies favorited by the user.
     - Returns: A list of favorited movies. Might be empty.
     */
    func getFavoritesList() -> [Movie]
    
    /**
     Check multiple favorites at once, and set the `isFavorite` property accordingly.
     - Parameter movies: The movie list to be checked.
     */
    func checkFavorites(on movies: [Movie])
}
