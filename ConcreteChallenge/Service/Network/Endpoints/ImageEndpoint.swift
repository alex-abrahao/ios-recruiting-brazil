//
//  ImageEndpoint.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/**
Provides requests for image operations
 
 - Returns: The request for a determinated operation
 */
enum ImageEndpoint: Endpoint {
    
    /**
     Get the genre list
     */
    case image(width: Int, path: String? = nil)
    
    // MARK: - HTTPMethod
    var method: APIHTTPMethod {
        switch self {
        case .image:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .image(let width, let path):
            guard let path = path else { return "" }
            return "/w\(width)\(path)"
        }
    }
    
    // MARK: - Parameters
    var parameters: APIParameters? {
        switch self {
        case .image:
            return nil
        }
    }
    
    // MARK: - URL -
    var completeURL: URL? {
        guard path != "" else { return nil }
        let completePath = NetworkInfo.ProductionServer.imageBaseURL + path
        return URL(string: completePath)
    }
}
