//
//  PopularsFeedTests.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 20/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import KIF
import Quick
@testable import Movs

class PopularsFeedTests: QuickSpec {
    
    override func spec() {
        
        var window: UIWindow!
        var viewController: PopularsVC!
        var presenter: PopularsPresenter!
        var movieClient: MovieClientMock!
        var favoriteClient: FavoriteClientMock!
        
        beforeEach {
            window = UIWindow(frame: UIScreen.main.bounds)
            movieClient = MovieClientMock()
            favoriteClient = FavoriteClientMock()
            presenter = PopularsPresenter(movieClient: movieClient, favoriteClient: favoriteClient)
            viewController = PopularsVC(presenter: presenter)
            
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
        
        describe("movie") {
            context("cells") {
                it("should enter a detail view when tapped") {
                    
                }
            }
        }
        
    }
}
