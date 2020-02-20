//
//  FeedCollectionDelegate.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class FeedCollectionDelegate: NSObject {
    
    enum DisplayType {
        case list
        case grid
    }
    
    // MARK: Properties
    var displayType: DisplayType = .list
    var didSelectItem: ((Int) -> Void)?
    var didScroll: ((_ scrollView: UIScrollView) -> Void)?
}

extension FeedCollectionDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }
}

// MARK: Flow Layout
extension FeedCollectionDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch displayType {
        case .grid:
            return CGSize(width: UIScreen.main.bounds.width/2 - 30, height: (UIScreen.main.bounds.width/2 - 30) * GridCollectionViewCell.imageAspect)
        case .list:
            return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width - 40) * ListCollectionViewCell.imageAspect)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch displayType {
        case .grid:
            return 0.0
        case .list:
            return 20.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch displayType {
        case .grid:
            return UIEdgeInsets(top: 20, left: 20, bottom: 15, right: 20)
        case .list:
            return UIEdgeInsets(top: 20, left: 0, bottom: 15, right: 0)
        }
    }
}
