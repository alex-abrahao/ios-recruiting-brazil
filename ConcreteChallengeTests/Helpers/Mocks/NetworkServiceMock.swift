//
//  NetworkServiceMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class NetworkServiceMock<T>: NetworkService {
    
    private(set) var didPerformRequest: Bool = false
    private(set) var didCancel: Bool = false
    var result: Result<T, Error>!
    var endpoint: Endpoint?
    
    func performRequest<T: Codable>(route: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        didPerformRequest = true
        endpoint = route
        
        if let result = self.result as? Result<T, Error> {
            completion(result)
        }
    }
    
    func cancel() {
        didCancel = true
    }
}
