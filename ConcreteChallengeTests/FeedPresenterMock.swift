//
//  FeedPresenterMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

class FeedPresenterMock: FeedPresenter {
    
    func mockLoad(movies: [Movie]) {
        self.movies = movies
    }
}
