//
//  FeedViewDelegateMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs


class FeedViewDelegateMock: NSObject, FeedViewDelegate {
    
    var calledStartLoading = false
    var calledFinishLoading = false
    var calledDisplayError = false
    var calledHideError = false
    var calledReloadFeed = false
    var calledResetFeedPosition = false
    var calledMoveData = false
    
    func reloadFeed() {
        calledReloadFeed = true
    }
    
    func resetFeedPosition() {
        calledResetFeedPosition = true
    }
    
    func moveData(movies: [Movie]) {
        calledMoveData = true
    }
    
    func startLoading() {
        calledStartLoading = true
    }
    
    func finishLoading() {
        calledFinishLoading = true
    }
    
    func exitView() {
        
    }
    
    func navigateToView(presenter: Presenter) {
        
    }
    
    func displayError(_ type: ErrorMessageType) {
        calledDisplayError = true
    }
    
    func hideError() {
        calledHideError = true
    }
}

