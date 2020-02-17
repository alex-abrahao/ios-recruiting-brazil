//
//  MovieClient.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

class MovieClient: MovieService {
    
    var service = NetworkService()

    func getPopular(page: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        
        service.performRequest(route: MovieEndpoint.popular(page: page)) { (result: Result<PopularResponse, Error>) in
            
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                LocalService.instance.checkFavorites(on: returnedMovies)
                completion(returnedMovies, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getGenreList(completion: @escaping ([Genre]?, Error?) -> Void) {
        
        service.performRequest(route: MovieEndpoint.genreList) { (result: Result<GenreListResponse, Error>) in
            
            switch result {
            case .success(let genreResponse):
                
                let genreList = genreResponse.genres
                LocalService.instance.setGenres(list: genreList)
                completion(genreList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func search(_ text: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        
        service.performRequest(route: MovieEndpoint.search(text)) { (result: Result<PopularResponse, Error>) in
            
            switch result {
            case .success(let movieResponse):
                
                let returnedMovies = movieResponse.results
                LocalService.instance.checkFavorites(on: returnedMovies)
                completion(returnedMovies, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
