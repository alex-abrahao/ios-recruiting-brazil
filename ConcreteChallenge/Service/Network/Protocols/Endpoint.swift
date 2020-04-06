//
//  Endpoint.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 18/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
