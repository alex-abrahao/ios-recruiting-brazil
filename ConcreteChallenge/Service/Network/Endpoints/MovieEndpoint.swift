//
//  MovieEndpoint.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/**
Provides requests for movie operations
 
 - Returns: The request for a determinated operation
 */
enum MovieEndpoint: Endpoint {
    /**
     Get the popular movies
     
     - Parameters:
        - page: The request page
     */
    case popular(page: Int)
    
    /**
     Get the genre list
     */
    case genreList
    
    /**
     Do a search query.
     - Parameter text: The text to be searched.
     */
    case search(_ text: String)
    
    // MARK: - HTTPMethod
    var method: APIHTTPMethod {
        switch self {
        case .popular, .genreList, .search:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .popular(let page):
            return "/movie/popular?api_key=\(NetworkInfo.APIParameterKey.apiKey)&page=\(page)"
        case .genreList:
            return "/genre/movie/list?api_key=\(NetworkInfo.APIParameterKey.apiKey)"
        case .search(let text):
            let safeText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return "/search/movie?api_key=\(NetworkInfo.APIParameterKey.apiKey)&query=\(safeText ?? "%20")"
        }
    }
    
    // MARK: - Parameters
    var parameters: APIParameters? {
        switch self {
        case .popular, .genreList, .search:
            return nil
        }
    }
    
    var completeURL: URL? {
        guard path != "" else { return nil }
        let completePath = NetworkInfo.ProductionServer.baseURL + path
        return URL(string: completePath)
    }
}
