//
//  MovieClientSpec.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

final class MovieClientSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MovieClient!
        var service: NetworkServiceMock<Any>!
        var favoriteClient: FavoriteClientMock!
        var genreClient: GenreClientSpy!
        
        beforeEach {
            service = NetworkServiceMock()
            favoriteClient = FavoriteClientMock()
            genreClient = GenreClientSpy()
            sut = MovieClient(networkService: service, favoriteClient: favoriteClient, genreClient: genreClient)
        }
        
        afterEach {
            service = nil
            favoriteClient = nil
            genreClient = nil
            sut = nil
        }
        
        describe("MovieClient") {
            context("when requesting popular movies") {
                let response = PopularResponse(page: 3, totalPages: 300, results: ModelStub.getMovieList())
                
                beforeEach {
                    service.result = .success(response)
                }
                
                it("should call perform request on service") {
                    sut.getPopular(page: response.page) { (_) in }
                    expect(service.didPerformRequest).to(beTrue())
                }
                
                it("should set the current page") {
                    sut.getPopular(page: response.page) { (_) in }
                    expect(sut.currentPage).to(equal(response.page))
                }
                
                it("should set the total pages") {
                    sut.getPopular(page: response.page) { (_) in
                        expect(sut.totalPages).to(equal(response.totalPages))
                    }
                }
                
                it("should check the favorites") {
                    sut.getPopular(page: response.page) { (_) in
                        expect(favoriteClient.didCheckFavorites).to(beTrue())
                    }
                }
                
                it("should set the movies") {
                    sut.getPopular(page: response.page) { (result) in
                        switch result {
                        case .success(let movies):
                            expect(movies).to(equal(response.results))
                        case .failure:
                            Nimble.fail("Expected success, got failure")
                        }
                    }
                }
                
                it("should not request on page 0") {
                    sut.getPopular(page: 0) { (result) in
                        expect(sut.currentPage).toNot(equal(0))
                        expect(service.didPerformRequest).to(beFalse())
                        if case Result<[Movie], Error>.success = result {
                            Nimble.fail("Expected failure, got success")
                        }
                    }
                }
                
                it("should not request on page more than max") {
                    let requestPage = sut.totalPages + 1
                    sut.getPopular(page: requestPage) { (result) in
                        expect(sut.currentPage).toNot(equal(requestPage))
                        expect(service.didPerformRequest).to(beFalse())
                        if case Result<[Movie], Error>.success = result {
                            Nimble.fail("Expected failure, got success")
                        }
                    }
                }
                
                it("should treat api failure") {
                    let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
                    service.result = .failure(expectedError)
                    sut.getPopular(page: response.page) { (result) in
                        switch result {
                        case .success:
                            Nimble.fail("Expected failure, got success")
                        case .failure(let error):
                            expect(error as NSError).to(equal(expectedError))
                        }
                    }
                }
            }
            
            context("when requesting search movies") {
                let searchText = "search text"
                let response = PopularResponse(page: 3, totalPages: 300, results: ModelStub.getMovieList())
                
                beforeEach {
                    service.result = .success(response)
                }
                
                it("should call perform request on service") {
                    sut.search(searchText) { (_) in }
                    expect(service.didPerformRequest).to(beTrue())
                }
                
                it("should check the favorites") {
                    sut.search(searchText) { (_) in
                        expect(favoriteClient.didCheckFavorites).to(beTrue())
                    }
                }
                
                it("should set the movies") {
                    sut.search(searchText) { (result) in
                        switch result {
                        case .success(let movies):
                            expect(movies).to(equal(response.results))
                        case .failure:
                            Nimble.fail("Expected success, got failure")
                        }
                    }
                }
                
                it("should treat api failure") {
                    let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
                    service.result = .failure(expectedError)
                    sut.search(searchText) { (result) in
                        switch result {
                        case .success:
                            Nimble.fail("Expected failure, got success")
                        case .failure(let error):
                            expect(error as NSError).to(equal(expectedError))
                        }
                    }
                }
            }
            
            context("when requesting genres") {
                let response = GenreListResponse(genres: ModelStub.getGenres())
                beforeEach {
                    service.result = .success(response)
                }
                
                it("should call perform request on service") {
                    sut.getGenreList { (_) in }
                    expect(service.didPerformRequest).to(beTrue())
                }
                
                it("should set the genres on the genre client") {
                    sut.getGenreList { (_) in
                        expect(genreClient.didSetGenres).to(beTrue())
                    }
                }
                
                it("should set the genres on the genre client") {
                    sut.getGenreList { (_) in
                        expect(genreClient.didSetGenres).to(beTrue())
                    }
                }
                
                it("should set the genres in the completion") {
                    sut.getGenreList { (result) in
                        switch result {
                        case .success(let genres):
                            expect(genres).to(equal(response.genres))
                        case .failure:
                            Nimble.fail("Expected success, got failure")
                        }
                    }
                }
                
                it("should treat api failure in the completion") {
                    let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
                    service.result = .failure(expectedError)
                    sut.getGenreList { (result) in
                        switch result {
                        case .success:
                            Nimble.fail("Expected failure, got success")
                        case .failure(let error):
                            expect(error as NSError).to(equal(expectedError))
                        }
                    }
                }
            }
        }
    }
}
