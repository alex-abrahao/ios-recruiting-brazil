//
//  HTTPTask.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 31/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}
