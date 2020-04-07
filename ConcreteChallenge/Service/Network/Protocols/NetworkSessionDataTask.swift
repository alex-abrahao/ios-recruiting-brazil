//
//  NetworkSessionDataTask.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 07/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol NetworkSessionTask: AnyObject {
    func resume()
    func cancel()
}

extension URLSessionTask: NetworkSessionTask { }
