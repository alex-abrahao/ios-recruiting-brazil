//
//  JSONParameterEncoder.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 01/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue) == nil {
                urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            }
        } catch {
            throw NetworkError.parameterEncodingFailed
        }
    }
}
