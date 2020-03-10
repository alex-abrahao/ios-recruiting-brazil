//
//  FeedCollectionDataSource.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher

final class FeedCollectionDataSource: NSObject {
    
    enum DisplayType {
        case list
        case grid
    }
    
    // MARK: Properties
    var displayType: DisplayType = .list
    var movies: [Movie] = []
    /// Function block to be called when the user taps the favorite button
    var favoritePressed: ((_ tag: Int) -> Void)?
    /// Function block to be called whenever prefetching is needed
    var prefetch: (() -> Void)?
    
    fileprivate func checkPrefetching(item: Int) {
        if item > movies.count - 5 {
            prefetch?()
        }
    }
}

extension FeedCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item < movies.count else {
            os_log("❌ - More cells than movie items %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.item]
        let feedCell: FeedCollectionViewCell
        
        switch displayType {
        case .grid:
            
            guard
                let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as? GridCollectionViewCell
            else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            feedCell = gridCell
            feedCell.hideError()
            
            if let imageURL = movie.completePosterURL {
                gridCell.filmImageView.kf.setImage(with: imageURL) { [weak gridCell] (result) in
                    switch result {
                    case .failure(let error):
                        gridCell?.displayError(.info("Image could not be downloaded"))
                        os_log("❌ - Image not downloaded %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                    default:
                        break
                    }
                }
            } else {
                gridCell.filmImageView.kf.setImage(with: movie.completePosterURL)
                gridCell.displayError(.missing("No poster available 😭"))
            }
                        
        case .list:
            guard
                let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell
            else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            feedCell = listCell
            feedCell.hideError()
            
            if let imageURL = movie.completeBackdropURL {
                listCell.filmImageView.kf.setImage(with: imageURL) { [weak listCell] (result) in
                    switch result {
                    case .failure(let error):
                        listCell?.displayError(.info("Image could not be downloaded"))
                        os_log("❌ - Image not downloaded %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                    default:
                        break
                    }
                }
            } else {
                listCell.filmImageView.kf.setImage(with: movie.completeBackdropURL)
                listCell.displayError(.missing("No backdrop available 😭"))
            }
        }
        
        feedCell.favoriteButton.tag = indexPath.item
        feedCell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        feedCell.titleLabel.text = movie.title
        feedCell.isFavorite = movie.isFavorite
        
        checkPrefetching(item: indexPath.item)
        
        return feedCell
    }
    
    // MARK: Button methods
    @objc func favoriteTapped(_ sender: UIButton) {
        favoritePressed?(sender.tag)
    }
}

