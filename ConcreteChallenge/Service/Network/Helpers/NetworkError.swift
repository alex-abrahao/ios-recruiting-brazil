//
//  NetworkError.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 31/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case nilParameters
    case parameterEncodingFailed
    case missingURL
    case missingData
    case noResponse
    case responseNot200(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .nilParameters:
            return "Parameters were nil."
        case .parameterEncodingFailed:
            return "Parameter encoding failed."
        case .missingURL:
            return "URL is nil."
        case .missingData:
            return "Data is nil"
        case .noResponse:
            return "No response from the request."
        case .responseNot200(let code):
            return "Response code was not 2xx. Status code: \(code)."
        }
    }
}
