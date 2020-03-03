//
//  FeedSelectionDelegate.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol FeedSelectionDelegate: AnyObject {
    
    func select(movie: Movie)
}
