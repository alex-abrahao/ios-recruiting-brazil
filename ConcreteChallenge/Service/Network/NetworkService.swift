//
//  NetworkService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation



final class NetworkService {
    
    private let session: URLSession
    private var task: URLSessionTask?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest<T: Codable>(route: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.missingData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedJson = try decoder.decode(T.self, from: data)
                    completion(.success(decodedJson))
                } catch {
                    completion(.failure(NSError(domain: "Value was not of type \(String(describing: T.self))", code: 4, userInfo: nil)))
                }
            }
        } catch {
            completion(.failure(error))
        }

        task?.resume()
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        
        return try route.asURLRequest()
    }
}
