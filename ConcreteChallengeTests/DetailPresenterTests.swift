//
//  DetailPresenterTests.swift
//  ConcreteChallengeTests
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import XCTest
@testable import Movs

class DetailPresenterTests: XCTestCase {
    
    var movieMock: Movie!
    var sut: DetailPresenter!
    var delegate: DetailViewDelegate!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieMock = MovieStub.getMovieList()[0]
        sut = DetailPresenter(movie: movieMock)
        delegate = DetailViewDelegateMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieMock = nil
        sut = nil
        delegate = nil
    }

    func testViewData() {
        
        // given
        let infoType: DetailInfoType
        
        // when
        infoType = sut.getDetailInfo(row: 1)
        
        // then
        switch infoType {
        case .title(let title):
            XCTAssertTrue(title == movieMock.title)
        default:
            XCTFail("Error: Wrong info type")
        }
    }
}
