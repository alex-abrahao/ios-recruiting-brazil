//
//  ListCollectionViewDataSource.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher

class ListCollectionViewDataSource: NSObject, FeedCollectionViewDataSource {
    
    weak var feedPresenter: FeedPresenter?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPresenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell,
            let itemData = feedPresenter?.getItemData(item: indexPath.item)
        else {
            os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown identifier")
        }
        cell.hideError()
        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        cell.titleLabel.text = itemData.title
        cell.filmImageView.kf.indicatorType = .activity
        if let imageURL = itemData.backdropURL {
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
            cell.filmImageView.kf.setImage(with: itemData.backdropURL)
            cell.displayError(.missing("No backdrop available 😭"))
        }
        cell.isFavorite = itemData.isFavorite
        
        return cell
    }
    
    // MARK: Button methods
    @objc func favoriteTapped(_ sender: UIButton) {
        feedPresenter?.favoriteStateChanged(tag: sender.tag)
    }
}
