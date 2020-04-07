//
//  URLSessionMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 07/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class NetworkSessionMock: NetworkSession {
    
    enum Response {
        case success
        case failure
    }
    
    var expectedResponse: Response = .success
    var task: NetworkSessionTaskSpy = NetworkSessionTaskSpy()
    var lastRequest: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionTask {
        lastRequest = request
        
        let response: HTTPURLResponse?
        let data: Data?
        let error: Error?
        switch expectedResponse {
        case .success:
            response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = ModelStub.moviesResponseJson
            error = nil
        case .failure:
            response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
            data = nil
            error = NSError(domain: "Error", code: 0, userInfo: nil)
        }
        
        completionHandler(data, response, error)
        
        return task
    }
}
