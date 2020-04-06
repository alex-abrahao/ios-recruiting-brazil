//
//  DetailViewDelegateSpy.swift
//  ConcreteChallengeTests
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class DetailViewDelegateSpy: NSObject, DetailViewDelegate {
    
    private(set) var calledStartLoading = false
    private(set) var calledFinishLoading = false
    private(set) var calledSetFavorite = false
    private(set) var calledDisplayError = false
    private(set) var calledHideError = false
    private(set) var calledSetGenres = false
    private(set) var calledReloadData = false
    
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
