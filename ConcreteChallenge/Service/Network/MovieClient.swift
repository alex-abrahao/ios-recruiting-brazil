//
//  MovieClient.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

class MovieClient: MovieService {
    
    var service = NetworkService()
    
    private(set) var currentPage: Int = 0
    private(set) var totalPages: Int = 500

    func getPopular(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard page <= totalPages else { return }
        
        currentPage = page
        
        service.performRequest(route: MovieEndpoint.popular(page: page)) { [weak self] (result: Result<PopularResponse, Error>) in
                        
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                LocalService.instance.checkFavorites(on: returnedMovies)
                self?.totalPages = movieResponse.totalPages
                completion(.success(returnedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGenreList(completion: @escaping (Result<[Genre], Error>) -> Void) {
        
        service.performRequest(route: MovieEndpoint.genreList) { (result: Result<GenreListResponse, Error>) in
            
            switch result {
            case .success(let genreResponse):
                
                let genreList = genreResponse.genres
                LocalService.instance.setGenres(list: genreList)
                completion(.success(genreList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func search(_ text: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        service.performRequest(route: MovieEndpoint.search(text)) { (result: Result<PopularResponse, Error>) in
            
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                LocalService.instance.checkFavorites(on: returnedMovies)
                completion(.success(returnedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
