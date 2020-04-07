//
//  NetworkSession.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 07/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol NetworkSession: AnyObject {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionTask
}

extension URLSession: NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionTask {
        let dataTask: URLSessionDataTask = self.dataTask(with: request, completionHandler: completionHandler)
        return dataTask
    }
}
