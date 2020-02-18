//
//  ListCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: FeedCollectionViewCell {
    
    // MARK: - Properties -
    /// Height / Width
    static let imageAspect: CGFloat = (1080/1920)
    
    // MARK: - Methods -
    override func setupConstraints() {
        
        filmImageView.snp.makeConstraints { (make) in
            let imageWidth = UIScreen.main.bounds.width - 40
            make.center.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth * ListCollectionViewCell.imageAspect)
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
}
