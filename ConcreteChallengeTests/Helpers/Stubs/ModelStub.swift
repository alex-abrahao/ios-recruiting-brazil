//
//  ModelStub.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class ModelStub {
    
    static var moviesResponseJson: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "MoviesResponseStub", ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
    
    static var moviesResponseNoImageJson: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "MoviesResponseNoImageStub", ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
    
    static var genresResponseJson: Data {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "GenreListStub", ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
    
    static func getMovieResponse() -> PopularResponse {
        let jsonData = moviesResponseJson
        let decoder = JSONDecoder()
        return try! decoder.decode(PopularResponse.self, from: jsonData)
    }
    
    static func getMovieList() -> [Movie] {
        
        let decodedJson = getMovieResponse()
        return decodedJson.results
    }
    
    static func getMovieWithNoImageList() -> [Movie] {
        
        let jsonData = moviesResponseNoImageJson
        let decoder = JSONDecoder()
        let decodedJson = try! decoder.decode(PopularResponse.self, from: jsonData)
        
        return decodedJson.results
    }
    
    static func getGenres() -> [Genre] {
        
        let jsonData = genresResponseJson
        let decoder = JSONDecoder()
        let decodedJson = try! decoder.decode(GenreListResponse.self, from: jsonData)
        
        return decodedJson.genres
    }
}
