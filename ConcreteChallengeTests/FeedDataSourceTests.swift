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
        
        var sut: FeedCollectionDataSource!
        var feedCollectionView: UICollectionView!
        var moviesList: [Movie]!
        var didPrefetch: Bool!
        
        beforeEach {
            
            sut = FeedCollectionDataSource()
            
            feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            feedCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
            feedCollectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
            feedCollectionView.dataSource = sut
            
            moviesList = Stub.getMovieList()
            sut.movies = moviesList
            feedCollectionView.reloadData()
            didPrefetch = false
            
            sut.favoritePressed = { tag in
                moviesList[tag].isFavorite = true
                feedCollectionView.reloadData()
            }
            
            sut.prefetch = {
                didPrefetch = true
            }
        }
        
        describe("displaying movies") {
            
                
            it("should display the correct number of items") {
                
                expect(sut.collectionView(feedCollectionView, numberOfItemsInSection: 0)) == sut.movies.count
            }
            
            context("in cells") {
                
                it("should load correctly first cell") {
                    
                    let indexPath = IndexPath(item: 0, section: 0)
                    let cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! FeedCollectionViewCell
                    
                    expect(cell.titleLabel.text) == moviesList.first!.title
                    expect(cell.isFavorite) == moviesList.first!.isFavorite
                }
                
                it("should load correctly middle cell") {
                    
                    let item: Int = moviesList.count/2
                    let indexPath = IndexPath(item: item, section: 0)
                    let cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! FeedCollectionViewCell
                    
                    expect(cell.titleLabel.text) == moviesList[item].title
                    expect(cell.isFavorite) == moviesList[item].isFavorite
                }
                
                it("should load correctly last cell") {
                    
                    let indexPath = IndexPath(item: moviesList.count - 1, section: 0)
                    let cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! FeedCollectionViewCell
                    
                    expect(cell.titleLabel.text) == moviesList.last!.title
                    expect(cell.isFavorite) == moviesList.last!.isFavorite
                }
            }
            
            context("when reaching end of content") {
                it("should prefetch new data") {
                    
                    let indexPath = IndexPath(item: moviesList.count - 4, section: 0)
                    let _ = sut.collectionView(feedCollectionView, cellForItemAt: indexPath)
                    
                    expect(didPrefetch) == true
                }
            }
            
            context("with no backdrop image on list view mode") {
                it("should display an error message in the cell") {
                    
                    // Arrange
                    let indexPath = IndexPath(item: 0, section: 0)
                    moviesList = Stub.getMovieWithNoImageList()
                    sut.movies = moviesList
                    sut.displayType = .list
                    
                    // Act
                    feedCollectionView.reloadData()
                    let cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! ListCollectionViewCell
                    
                    // Assert
                    expect(cell.errorView.superview).toNot(beNil())
                }
            }
            
            context("with no backdrop image on grid view mode") {
                it("should display an error message in the cell") {
                    
                    // Arrange
                    let indexPath = IndexPath(item: 0, section: 0)
                    moviesList = Stub.getMovieWithNoImageList()
                    sut.movies = moviesList
                    sut.displayType = .grid
                    
                    // Act
                    feedCollectionView.reloadData()
                    let cell = sut.collectionView(feedCollectionView, cellForItemAt: indexPath) as! GridCollectionViewCell
                    
                    // Assert
                    expect(cell.errorView.superview).toNot(beNil())
                }
            }
            
            context("on list cells") {
                
                it("should load the correct cell type") {
                    
                    sut.displayType = .list
                    feedCollectionView.reloadData()
                    
                    expect(sut.collectionView(feedCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)) is ListCollectionViewCell) == true
                }
            }
            
            context("on grid cells") {
                
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
