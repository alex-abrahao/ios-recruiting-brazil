//
//  FeedDataSourceTests.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest
@testable import Movs

class FeedDataSourceTests: XCTestCase {
    
    var movieListMock: [Movie]!
    var sut: FeedCollectionViewDataSource!
    var feedCollectionView: UICollectionView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let movie = Movie(id: 330457,
                          title: "Frozen II",
                          overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
                          genreIDs: [12, 16, 10402, 10751],
                          posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
                          backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
                          releaseDate: "2019-11-20")
        movieListMock = [movie, movie, movie, movie, movie]
        
        sut = FeedCollectionViewDataSource()
        sut.movies = movieListMock
        
        feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        feedCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        feedCollectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
        feedCollectionView.dataSource = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieListMock = nil
        sut = nil
        feedCollectionView = nil
    }

    func testNumberOfItems() {
        
        // given
        let numberOfItems = movieListMock.count
        
        // when
        feedCollectionView.reloadData()
        
        // then
        XCTAssertTrue(numberOfItems == sut.collectionView(feedCollectionView, numberOfItemsInSection: 0))
    }
}
