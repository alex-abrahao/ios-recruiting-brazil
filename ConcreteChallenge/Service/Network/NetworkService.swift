//
//  NetworkService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Alamofire

class NetworkService {
    
    func performRequest<T: Codable>(route: APIConfiguration, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(route).validate().responseJSON { (response: DataResponse<Any, AFError>?) in
            
            switch response?.result {
            case .success:
                
                guard let jsonData = response?.data else {
                    completion(.failure(NSError(domain: "Response had no data", code: 3, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedJson = try decoder.decode(T.self, from: jsonData)
                    completion(.success(decodedJson))
                } catch {
                    completion(.failure(NSError(domain: "Value was not of type \(String(describing: T.self))", code: 4, userInfo: nil)))
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            case .none:
                completion(.failure(NSError(domain: "No data returned", code: 2, userInfo: nil)))
            }
        }
    }
}
