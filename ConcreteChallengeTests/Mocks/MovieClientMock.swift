//
//  MovieClientMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 21/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class MovieClientMock: MovieClientProtocol {
    
    var currentPage: Int = 0
    
    var totalPages: Int = 3
    
    var movies: [Movie] = []
    
    func getPopular(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let movies = Stub.getMovieList()
        FavoriteClientMock().checkFavorites(on: movies)
        self.movies = movies
        completion(.success(movies))
    }
    
    func getGenreList(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let genreList = Stub.getGenres()
        completion(.success(genreList))
    }
    
    func search(_ text: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(.success([]))
    }
}
