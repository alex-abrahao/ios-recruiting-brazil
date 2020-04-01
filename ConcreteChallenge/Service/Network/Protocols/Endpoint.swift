//
//  Endpoint.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 18/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var task: HTTPTask { get }
    var completeURL: URL? { get }
}

extension Endpoint {
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = completeURL else {
            throw NetworkError.missingURL
        }
        
        var urlRequest = URLRequest(url: url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw NetworkError.parameterEncodingFailed
            }
        }
        
        return urlRequest
    }
}
