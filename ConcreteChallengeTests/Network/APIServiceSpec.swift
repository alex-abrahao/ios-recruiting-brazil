//
//  APIServiceSpec.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 07/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

final class APIServiceSpec: QuickSpec {
    
    override func spec() {
        
        var sut: APIService!
        var session: NetworkSessionMock!
        var endpoint: Endpoint!
        
        beforeEach {
            session = NetworkSessionMock()
            sut = APIService(session: session)
            endpoint = MovieEndpoint.popular(page: 1)
        }
        
        afterEach {
            session = nil
            sut = nil
            endpoint = nil
        }
        
        describe("APIService") {
            context("when a request is received") {
                it("should build the correct URL with parameters") {
                    
                    let scheme = "https"
                    let host = "api.themoviedb.org"
                    let path = "/3/movie/popular"
                    let expectedQueryItems = [
                        URLQueryItem(name: "api_key", value: NetworkInfo.APIParameterKey.apiKey),
                        URLQueryItem(name: "page", value: "1")
                    ]
                    
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<PopularResponse, Error>) in }
                    
                    // Assert
                    let components = URLComponents(url: session.lastRequest!.url!, resolvingAgainstBaseURL: true)
                    expect(components?.scheme).to(equal(scheme))
                    expect(components?.host).to(equal(host))
                    expect(components?.path).to(equal(path))
                    expect(components?.queryItems).to(contain(expectedQueryItems))
                }
                
                it("should be of the correct method") {
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<PopularResponse, Error>) in }
                    // Assert
                    expect(session.lastRequest?.httpMethod).to(equal(endpoint.method.rawValue))
                }
                
                it("should call resume task") {
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<PopularResponse, Error>) in }
                    // Assert
                    expect(session.task.didResume).to(beTrue())
                }
            }
            
            context("when session returns successfully") {
                it("should call the completion with the correct model decoded") {
                    // Arrange
                    session.expectedResponse = .success
                    session.returnsModelMock = true
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<ModelMock, Error>) in
                        
                        // Assert
                        guard case Result<ModelMock, Error>.success(let model) = result else {
                            Nimble.fail("Service should return sucess result")
                            return
                        }
                        expect(model).to(equal(session.modelMock))
                    }
                }
            }
            
            context("when there is an error") {
                it("should call the completion with a failure") {
                    // Arrange
                    session.expectedResponse = .failure
                    session.returnsModelMock = true
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<ModelMock, Error>) in
                        
                        // Assert
                        guard case Result<ModelMock, Error>.failure(let error) = result else {
                            Nimble.fail("Service should return failure result")
                            return
                        }
                        guard let errorMock = error as? NetworkErrorMock else {
                            Nimble.fail("Service should return the error given by the session")
                            return
                        }
                        expect(errorMock).to(equal(session.lastError))
                    }
                }
            }
        }
    }
}
