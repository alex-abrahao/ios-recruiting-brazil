//
//  ParameterEncoder.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 31/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

public typealias Parameters = [String : Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
