//
//  NetworkService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol NetworkService: AnyObject {
    func performRequest<T: Codable>(route: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
    func cancel()
}
