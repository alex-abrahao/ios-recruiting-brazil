//
//  PopularsFeedTests.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 20/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import KIF
import Quick
import Nimble
@testable import Movs

final class PopularsFeedTests: QuickSpec {
    
    override func spec() {
        
        var window: UIWindow!
        var viewController: PopularsVC!
        var presenter: PopularsPresenter!
        var movieClient: MovieClientMock!
        var favoriteClient: FavoriteClientMock!
        var coordinator: PopularsCoordinator!
        
        beforeEach {
            window = UIWindow(frame: UIScreen.main.bounds)
            movieClient = MovieClientMock()
            favoriteClient = FavoriteClientMock()
            presenter = PopularsPresenter(movieClient: movieClient, favoriteClient: favoriteClient)
            coordinator = PopularsCoordinator()
            viewController = PopularsVC(presenter: presenter)
            viewController.selectionDelegate = coordinator
            coordinator.rootViewController = NavigationController(rootViewController: viewController)
            
            window.rootViewController = coordinator.rootViewController
            window.makeKeyAndVisible()
            
            let _ = viewController.view
        }
        
        afterEach {
            window = nil
            movieClient = nil
            favoriteClient = nil
            presenter = nil
            coordinator = nil
            viewController = nil
        }
        
        describe("movie") {
            
            context("cells") {
                
                it("should display the correct title and favorite status") {
                    
                    let item = 2
                    let movie = presenter.movies[item]
                    
                    let cell = self.tester.waitForCell(at: IndexPath(item: item, section: 0), in: viewController.feedCollectionView) as! FeedCollectionViewCell
                    
                    expect(cell.titleLabel.text) == movie.title
                    expect(cell.isFavorite) == movie.isFavorite
                }
                
                it("should enter the correct detail view when tapped") {
                    
                    let item = 2
                    let movie = presenter.movies[item]
                    self.tester.tapItem(at: IndexPath(item: item, section: 0), in: viewController.feedCollectionView)
                    
                    let cell = self.tester.waitForCell(at: IndexPath(row: 1, section: 0), inTableViewWithAccessibilityIdentifier: "detailTableView") as! DefaultInfoTableCell
                    
                    expect(cell.textLabel?.text) == movie.title
                }
            }
        }
        
    }
}
