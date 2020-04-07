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
        
        beforeEach {
            session = NetworkSessionMock()
            sut = APIService(session: session)
        }
        
        afterEach {
            session = nil
            sut = nil
        }
        
        describe("APIService") {
            context("when a request is received") {
                
                var endpoint: Endpoint!
                
                beforeEach {
                    endpoint = MovieEndpoint.popular(page: 1)
                }
                
                it("should build the correct URL with parameters from an endpoint") {
                    
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<PopularResponse, Error>) in }
                    // Assert
                    let expectedURLString = "https://api.themoviedb.org/3/movie/popular?api_key=\(NetworkInfo.APIParameterKey.apiKey)&page=1"
                    expect(session.lastRequest?.url?.absoluteString).to(equal(expectedURLString))
                }
                
                it("should call resume task") {
                    
                    // Act
                    sut.performRequest(route: endpoint) { (result: Result<PopularResponse, Error>) in }
                    // Assert
                    expect(session.task.didResume).to(beTrue())
                }
            }
        }
    }
}
