//
//  MovieClient.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

final class MovieClient: MovieClientProtocol {
    
    var networkService: NetworkService
    var favoriteClient: FavoriteClientProtocol
    var genreClient: GenreClientProtocol
    
    private(set) var currentPage: Int = 0
    private(set) var totalPages: Int = 500
    
    init(networkService: NetworkService = NetworkService(),
         favoriteClient: FavoriteClientProtocol = FavoriteClient(),
         genreClient: GenreClientProtocol = GenreClient()) {
        
        self.networkService = networkService
        self.favoriteClient = favoriteClient
        self.genreClient = genreClient
    }

    func getPopular(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard page <= totalPages else { return }
        
        currentPage = page
        
        networkService.performRequest(route: MovieEndpoint.popular(page: page)) { [weak self] (result: Result<PopularResponse, Error>) in
                        
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                self?.fillImageURLs(movies: returnedMovies)
                self?.favoriteClient.checkFavorites(on: returnedMovies)
                self?.totalPages = movieResponse.totalPages
                completion(.success(returnedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGenreList(completion: @escaping (Result<[Genre], Error>) -> Void) {
        
        networkService.performRequest(route: MovieEndpoint.genreList) { [weak self] (result: Result<GenreListResponse, Error>) in
            
            switch result {
            case .success(let genreResponse):
                
                let genreList = genreResponse.genres
                self?.genreClient.setGenres(list: genreList)
                completion(.success(genreList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func search(_ text: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        networkService.performRequest(route: MovieEndpoint.search(text)) { [weak self] (result: Result<PopularResponse, Error>) in
            
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                self?.fillImageURLs(movies: returnedMovies)
                self?.favoriteClient.checkFavorites(on: returnedMovies)
                completion(.success(returnedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    fileprivate func fillImageURLs(movies: [Movie]) {
        movies.forEach { (movie) in
            if let posterPath = movie.posterPath {
                movie.posterURL = networkService.buildURL(from: ImageEndpoint.image(width: 500, path: posterPath))
            }
            if let backdropPath = movie.backdropPath {
                movie.backdropURL = networkService.buildURL(from: ImageEndpoint.image(width: 780, path: backdropPath))
            }
        }
    }
}
