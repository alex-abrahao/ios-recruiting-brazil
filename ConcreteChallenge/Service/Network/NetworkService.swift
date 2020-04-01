//
//  NetworkService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 17/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let session: URLSession
    private var task: URLSessionTask?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest<T: Codable>(route: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.missingData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedJson = try decoder.decode(T.self, from: data)
                    completion(.success(decodedJson))
                } catch {
                    completion(.failure(NSError(domain: "Value was not of type \(String(describing: T.self))", code: 4, userInfo: nil)))
                }
            }
        } catch {
            completion(.failure(error))
        }

        task?.resume()
    }
    
    func buildURL(from route: Endpoint) -> URL? {
        do {
            let url = try buildRequest(from: route).url
            return url
        } catch {
            return nil
        }
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        
        guard let baseURL = route.baseURL else {
            throw NetworkError.missingURL
        }
        var request = URLRequest(url: baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: 60.0)
        request.httpMethod = route.method.rawValue
        
        switch route.task {
        case .request:
            request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        case .requestParameters(let bodyParameters, let urlParameters):
            try configureParameters(request: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
            addAdditionalHeaders(additionHeaders, request: &request)
            try configureParameters(request: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        }
        
        return request
    }
    
    fileprivate func configureParameters(request: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        
        if let bodyParameters = bodyParameters {
            try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        if let urlParameters = urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
    }
    
    fileprivate func addAdditionalHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        
        guard let headers = headers else { return }
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
