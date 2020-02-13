//
//  GridCollectionViewDataSource.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher

class GridCollectionViewDataSource: NSObject, FeedCollectionViewDataSource {
    
    weak var feedPresenter: FeedPresenter?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPresenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as? GridCollectionViewCell,
            let itemData = feedPresenter?.getItemData(item: indexPath.item)
        else {
            os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown identifier")
        }
        cell.hideError()
        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(FeedVC.favoriteTapped(_:)), for: .touchUpInside)
        cell.titleLabel.text = itemData.title
        cell.filmImageView.kf.indicatorType = .activity
        if let imageURL = itemData.posterURL {
            cell.filmImageView.kf.setImage(with: imageURL) { [weak cell] (result) in
                switch result {
                case .failure(let error):
                    cell?.displayError(.info("Image could not be downloaded"))
                    os_log("❌ - Image not downloaded %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                default:
                    break
                }
            }
        } else {
            cell.filmImageView.kf.setImage(with: itemData.posterURL)
            cell.displayError(.missing("No backdrop available 😭"))
        }
        cell.isFavorite = itemData.isFavorite
        
        return cell
    }
}

