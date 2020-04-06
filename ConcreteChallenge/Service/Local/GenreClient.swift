//
//  GenreClient.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

fileprivate typealias GenresDict = [Int : Genre]

final class GenreClient {
    
    var service: LocalService
    
    fileprivate let fileNameIdentifier: String = "GenreList"
    
    init(service: LocalService = JSONDocumentsSaverService()) {
        self.service = service
    }
}

extension GenreClient: GenreClientProtocol {
    
    func setGenres(list: [Genre]) {
        
        var genresToSave: GenresDict = [:]
        list.forEach { genresToSave[$0.id] = $0 }
        
        service.save(genresToSave, fileName: fileNameIdentifier)
    }
    
    func getGenreList(from genreIDs: [Int]) -> [Genre]? {
        
        var foundGenres = [Genre]()
        guard let genreDict: GenresDict = service.get(fileName: fileNameIdentifier) else {
            // There's no genres saved locally
            return nil
        }
        for id in genreIDs {
            guard let genre = genreDict[id] else {
                // Means it got a genre not in the list
                return nil
            }
            foundGenres.append(genre)
        }
        return foundGenres
    }
}
