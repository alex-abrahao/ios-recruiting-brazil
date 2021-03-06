//
//  PopularResponse.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

struct PopularResponse: Codable {
    
    let page: Int
    let totalPages: Int
    let results: [Movie]
}

extension PopularResponse {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}
