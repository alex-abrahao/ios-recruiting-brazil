//
//  FeedViewDelegateSpy.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs


final class FeedViewDelegateSpy: NSObject, FeedViewDelegate {
    
    var calledStartLoading = false
    var calledFinishLoading = false
    var calledDisplayError = false
    var calledHideError = false
    var calledReloadFeed = false
    var calledResetFeedPosition = false
    var calledMoveData = false
    var calledNavigateToDetail = false
    var calledDatasource = false
    var calledExitView = false
    
    func reloadFeed() {
        calledReloadFeed = true
    }
    
    func resetFeedPosition() {
        calledResetFeedPosition = true
    }
    
    func moveData(movies: [Movie]) {
        calledMoveData = true
    }
    
    func dataSource(movies: [Movie]) {
        calledDatasource = true
    }
    
    func navigateToDetail(movie: Movie) {
        calledNavigateToDetail = true
    }
    
    func startLoading() {
        calledStartLoading = true
    }
    
    func finishLoading() {
        calledFinishLoading = true
    }
    
    func exitView() {
        calledExitView = false
    }
    
    func displayError(_ type: ErrorMessageType) {
        calledDisplayError = true
    }
    
    func hideError() {
        calledHideError = true
    }
}

