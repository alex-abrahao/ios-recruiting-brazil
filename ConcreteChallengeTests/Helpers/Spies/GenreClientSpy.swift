//
//  GenreClientSpy.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

@testable import Movs

final class GenreClientSpy: GenreClientProtocol {
    
    private(set) var didSetGenres: Bool = false
    private(set) var didGetGenreList: Bool = false
    
    func setGenres(list: [Genre]) {
        didSetGenres = true
    }
    
    func getGenreList(from genreIDs: [Int]) -> [Genre]? {
        didGetGenreList = true
        return []
    }
}
