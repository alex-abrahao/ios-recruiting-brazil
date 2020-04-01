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
    var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .genreList:
            return "/genre/movie/list"
        case .search:
            return "/search/movie?"
        }
    }
    
    // MARK: - Task
    var task: HTTPTask {
        switch self {
        case .popular(let page):
            let urlParameters: Parameters = [
                "api_key" : NetworkInfo.APIParameterKey.apiKey,
                "page" : page
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        case .genreList:
            let urlParameters: Parameters = [
                "api_key" : NetworkInfo.APIParameterKey.apiKey
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        case .search(let text):
            let safeText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let urlParameters: Parameters = [
                "api_key" : NetworkInfo.APIParameterKey.apiKey,
                "query" : safeText ?? "%20"
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        }
    }
    
    // MARK: - URL
    var baseURL: URL? {
        return URL(string: NetworkInfo.ProductionServer.baseURL)
    }
}
