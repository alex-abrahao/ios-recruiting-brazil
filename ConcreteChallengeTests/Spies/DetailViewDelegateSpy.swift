//
//  DetailViewDelegateSpy.swift
//  ConcreteChallengeTests
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

class DetailViewDelegateSpy: NSObject, DetailViewDelegate {
    
    var calledStartLoading = false
    var calledFinishLoading = false
    var calledSetFavorite = false
    var calledDisplayError = false
    var calledHideError = false
    var calledSetGenres = false
    var calledReloadData = false
    
    func reloadData(info: [DetailInfoType]) {
        calledReloadData = true
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
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        calledSetFavorite = true
    }
    
    func displayError(_ type: ErrorMessageType) {
        calledDisplayError = true
    }
    
    func hideError() {
        calledHideError = true
    }
}
