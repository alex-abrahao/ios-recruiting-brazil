//
//  MovieClient.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

class MovieClient: MovieService {
    
    var networkService: NetworkService
    var favoriteService: FavoriteService
    var genreService: GenreService
    
    private(set) var currentPage: Int = 0
    private(set) var totalPages: Int = 500
    
    init(networkService: NetworkService = NetworkService(),
         favoriteService: FavoriteService = FavoriteClient(),
         genreService: GenreService = GenreClient()) {
        
        self.networkService = networkService
        self.favoriteService = favoriteService
        self.genreService = genreService
    }

    func getPopular(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard page <= totalPages else { return }
        
        currentPage = page
        
        networkService.performRequest(route: MovieEndpoint.popular(page: page)) { [weak self] (result: Result<PopularResponse, Error>) in
                        
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                self?.favoriteService.checkFavorites(on: returnedMovies)
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
                self?.genreService.setGenres(list: genreList)
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
                self?.favoriteService.checkFavorites(on: returnedMovies)
                completion(.success(returnedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
