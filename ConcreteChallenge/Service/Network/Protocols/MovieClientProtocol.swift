//
//  MovieClientProtocol.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol MovieClientProtocol {
    
    /// Controls which page to load next on
    var currentPage: Int { get }
    /// Max number of pages, usually comes from the server
    var totalPages: Int { get }
    
    func getPopular(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getGenreList(completion: @escaping (Result<[Genre], Error>) -> Void)
    
    func search(_ text: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}
