//
//  FeedDataSourceTests.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class FeedDataSourceTests: QuickSpec {
    
    override func spec() {
        
        var sut: FeedCollectionViewDataSource!
        var feedCollectionView: UICollectionView!
        var moviesList: [Movie]!
        
        beforeEach {
            
            sut = FeedCollectionViewDataSource()
            
            feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            feedCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
            feedCollectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
            feedCollectionView.dataSource = sut
            
            moviesList = MovieStub.getMovieList()
            sut.movies = moviesList
            feedCollectionView.reloadData()
            
            sut.favoritePressed = { tag in
                moviesList[tag].isFavorite = true
                feedCollectionView.reloadData()
            }
        }
        
        describe("loading") {
            
            context("movies") {
                
                it("should display the correct number of items") {
                    
                    expect(sut.collectionView(feedCollectionView, numberOfItemsInSection: 0)) == sut.movies.count
                }
            }
            
            context("list cells") {
                
                it("should load the correct cell type") {
                    
                    sut.displayType = .list
                    feedCollectionView.reloadData()
                    
                    expect(sut.collectionView(feedCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)) is ListCollectionViewCell) == true
                }
            }
            
            context("grid cells") {
                
                it("should load the correct cell type") {
                    
                    sut.displayType = .grid
                    feedCollectionView.reloadData()
                    
                    expect(sut.collectionView(feedCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)) is GridCollectionViewCell) == true
                }
            }
        }
        
        describe("interacting") {
            
            context("with favorite button") {
                it("should update the correct cell") {
                    
                    // Arrange
                    let indexPath = IndexPath(item: 0, section: 0)
                    var cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! FeedCollectionViewCell
                    
                    // Act
                    cell.favoriteButton.sendActions(for: .touchUpInside)
                    
                    // Assert
                    cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! FeedCollectionViewCell
                    expect(cell.isFavorite) == true
                }
            }
        }
    }
}
