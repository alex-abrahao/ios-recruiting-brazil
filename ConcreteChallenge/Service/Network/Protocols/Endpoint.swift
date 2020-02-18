//
//  Endpoint.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 18/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Alamofire

protocol Endpoint: APIConfiguration {

    typealias APIHTTPMethod = HTTPMethod
    typealias APIParameters = Parameters
    
    var completeURL: URL? { get }
}

extension APIConfiguration where Self: Endpoint {
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = completeURL else {
            throw URLError(URLError.Code.badURL, userInfo: [:])
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
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
