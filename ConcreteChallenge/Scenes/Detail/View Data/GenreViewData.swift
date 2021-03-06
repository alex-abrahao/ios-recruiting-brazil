//
//  GenreViewData.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

struct GenreViewData {
    
    let genres: String
    
    static var mockData: GenreViewData {
        return GenreViewData(genres: "Action, Adventure")
    }
}
