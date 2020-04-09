//
//  MovieEndPointSpec.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

final class MovieEndPointSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MovieEndpoint!
        
        afterEach {
            sut = nil
        }
        
        describe("MovieEndpoint") {
            context("http method") {
                it("should return get for populars") {
                    sut = .popular(page: 1)
                    expect(sut.method).to(equal(HTTPMethod.get))
                }
                it("should return get for search") {
                    sut = .search("text")
                    expect(sut.method).to(equal(HTTPMethod.get))
                }
                it("should return get for genre") {
                    sut = .genreList
                    expect(sut.method).to(equal(HTTPMethod.get))
                }
            }
            context("http task") {
                it("should return request with parameters for populars") {
                    sut = .popular(page: 1)
                    guard case HTTPTask.requestParameters(let bodyParm, let urlParm) = sut.task else {
                        Nimble.fail("Request should be of type requestParameters")
                        return
                    }
                    expect(bodyParm).to(beNil())
                    expect(urlParm).toNot(beNil())
                    expect(urlParm!["api_key"] as? String).to(equal(NetworkInfo.APIParameterKey.apiKey))
                    expect(urlParm!["page"] as? Int).to(equal(1))
                }
                it("should return request with parameters for search") {
                    sut = .search("text")
                    guard case HTTPTask.requestParameters(let bodyParm, let urlParm) = sut.task else {
                        Nimble.fail("Request should be of type requestParameters")
                        return
                    }
                    expect(bodyParm).to(beNil())
                    expect(urlParm).toNot(beNil())
                    expect(urlParm!["api_key"] as? String).to(equal(NetworkInfo.APIParameterKey.apiKey))
                    expect(urlParm!["query"] as? String).to(equal("text"))
                }
                it("should return request with parameters for genre") {
                    sut = .genreList
                    guard case HTTPTask.requestParameters(let bodyParm, let urlParm) = sut.task else {
                        Nimble.fail("Request should be of type requestParameters")
                        return
                    }
                    expect(bodyParm).to(beNil())
                    expect(urlParm).toNot(beNil())
                    expect(urlParm!["api_key"] as? String).to(equal(NetworkInfo.APIParameterKey.apiKey))
                }
            }
            context("path") {
                it("should return correctly for populars") {
                    sut = .popular(page: 1)
                    expect(sut.path).to(equal("/movie/popular"))
                }
                it("should return correctly for search") {
                    sut = .search("text")
                    expect(sut.path).to(equal("/search/movie"))
                }
                it("should return correctly for genre") {
                    sut = .genreList
                    expect(sut.path).to(equal("/genre/movie/list"))
                }
            }
            context("base url") {
                it("should return correctly at any case") {
                    sut = .popular(page: 1)
                    expect(sut.baseURL).to(equal(URL(string: NetworkInfo.ProductionServer.baseURL)))
                }
            }
            context("headers") {
                it("should return correctly at any case") {
                    sut = .popular(page: 1)
                    expect(sut.headers).to(beNil())
                }
            }
        }
    }
}
