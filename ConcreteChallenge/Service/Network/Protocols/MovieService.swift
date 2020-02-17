//
//  MovieService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol MovieService {
    
    func getPopular(page: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    
    func getGenreList(completion: @escaping ([Genre]?, Error?) -> Void)
    
    func search(_ text: String, completion: @escaping ([Movie]?, Error?) -> Void)
}
