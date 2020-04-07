//
//  GridCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import SnapKit

final class GridCollectionViewCell: FeedCollectionViewCell {
    
    // MARK: - Properties -
    /// Height / Width
    static let imageAspect: CGFloat = (1920/1280)

    // MARK: - Methods -
    override func setupConstraints() {
        
        filmImageView.snp.makeConstraints { (make) in
            let imageWidth = UIScreen.main.bounds.width/2 - 30
            make.center.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth * GridCollectionViewCell.imageAspect)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(favoriteButton.snp.leading)
        }
    }
    
    override func setupAdditionalConfiguration() {
        super.setupAdditionalConfiguration()
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        accessibilityIdentifier = "GridCollectionViewCell"
    }
}
