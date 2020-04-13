//
//  NetworkServiceMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class NetworkServiceMock<U>: NetworkService {
    
    private(set) var didPerformRequest: Bool = false
    private(set) var didCancel: Bool = false
    var result: Result<U, Error>!
    var endpoint: Endpoint?
    
    func performRequest<T: Codable>(route: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        didPerformRequest = true
        endpoint = route
        
//        if let result = self.result as? Result<T, Error> {
//            completion(result)
//        }
        if let result = self.result {
            switch result {
            case .success(let value):
                if let tValue = value as? T {
                    completion(.success(tValue))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancel() {
        didCancel = true
    }
}
