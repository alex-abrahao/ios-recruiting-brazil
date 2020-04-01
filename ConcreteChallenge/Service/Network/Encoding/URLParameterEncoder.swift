//
//  URLParameterEncoder.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 01/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = []
            
            parameters.forEach { (key, value) in
                let itemValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: key, value: itemValue)
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue) == nil {
            urlRequest.setValue(ContentType.url.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
    }
}
