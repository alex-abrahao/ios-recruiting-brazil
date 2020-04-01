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
     Get an image.
     */
    case image(width: Int, path: String? = nil)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .image(let width, let path):
            guard let path = path else { return "" }
            return "/w\(width)\(path)"
        }
    }
    
    // MARK: - Task
    var task: HTTPTask {
        return .request
    }
    
    // MARK: - URL -
    var baseURL: URL? {
        return URL(string: NetworkInfo.ProductionServer.imageBaseURL)
    }
}
