//
//  FeedCollectionViewDelegateFlowLayout.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

protocol FeedCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    
    var feedPresenter: FeedPresenter? { get set }
}
