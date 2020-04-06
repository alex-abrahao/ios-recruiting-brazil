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
    
    private(set) var calledStartLoading = false
    private(set) var calledFinishLoading = false
    private(set) var calledDisplayError = false
    private(set) var calledHideError = false
    private(set) var calledReloadFeed = false
    private(set) var calledResetFeedPosition = false
    private(set) var calledMoveData = false
    private(set) var calledNavigateToDetail = false
    private(set) var calledDatasource = false
    private(set) var calledExitView = false
    
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

