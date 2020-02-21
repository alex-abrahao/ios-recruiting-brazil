//
//  Stub.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

class Stub {
    
    static func getMovieList() -> [Movie] {
        
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "MoviesResponseStub", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        let decoder = JSONDecoder()
        let decodedJson = try! decoder.decode(PopularResponse.self, from: jsonData)
        
        return decodedJson.results
    }
    
    static func getMovieWithNoImageList() -> [Movie] {
        
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "MoviesResponseNoImageStub", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        let decoder = JSONDecoder()
        let decodedJson = try! decoder.decode(PopularResponse.self, from: jsonData)
        
        return decodedJson.results
    }
    
    static func getGenres() -> [Genre] {
        
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: "GenreListStub", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        let decoder = JSONDecoder()
        let decodedJson = try! decoder.decode(GenreListResponse.self, from: jsonData)
        
        return decodedJson.genres
    }
}
