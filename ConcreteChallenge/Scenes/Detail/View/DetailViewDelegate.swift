//
//  DetailViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol DetailViewDelegate: ViewDelegate, FavoriteViewDelegate {
    
    /// Called whenever the data displayed must be reloaded
    func reloadData()
}
