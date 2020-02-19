//
//  GenreService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol GenreService {
    
    /**
     Saves the genre list locally.
     - Parameter list: The `Genre` list to be saved.
     - Important: The existing list will be overriten, may there be one.
     */
    func setGenres(list: [Genre])
    
    /**
     Get the locally stored genres.
     - Parameter genreIDs: List of genre IDs.
     - Returns: A list of the found `Genre` or `nil` if one or more genres were not found.
     - Important: If a genre is not found, it may be time to update the saved ones.
     */
    func getGenreList(from genreIDs: [Int]) -> [Genre]?
}
