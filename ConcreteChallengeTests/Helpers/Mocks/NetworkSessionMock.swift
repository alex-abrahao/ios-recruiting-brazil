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
        case errorFromAPI
        case failure
    }
    
    var expectedResponse: Response = .success
    var returnsModelMock: Bool = false
    var task: NetworkSessionTaskSpy = NetworkSessionTaskSpy()
    var lastRequest: URLRequest?
    var lastError: NetworkErrorMock?
    var modelMock: ModelMock = ModelMock(name: "Name", id: 123)
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkSessionTask {
        lastRequest = request
        
        let response: HTTPURLResponse?
        let data: Data?
        let error: NetworkErrorMock?
        switch expectedResponse {
        case .success:
            response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = returnsModelMock ? modelMock.getJsonData() : ModelStub.moviesResponseJson
            error = nil
        case .errorFromAPI:
            response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)
            data = returnsModelMock ? modelMock.getJsonData() : ModelStub.moviesResponseJson
            error = nil
        case .failure:
            response = nil
            data = nil
            error = NetworkErrorMock.generic
        }
        
        lastError = error
        completionHandler(data, response, error)
        
        return task
    }
}
