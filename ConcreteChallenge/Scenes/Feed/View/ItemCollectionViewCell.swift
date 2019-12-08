//
//  ItemCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import SnapKit

final class ItemCollectionViewCell: BaseCollectionViewCell {
    
    /// Height / Width
    static let imageAspect: CGFloat = (1080/1920)
    
    let filmImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override func setupUI() {
        self.backgroundColor = .yellow
        contentView.addSubview(filmImageView)
        filmImageView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        
        filmImageView.snp.makeConstraints { (make) in
            let imageWidth = UIScreen.main.bounds.width - 40
            make.center.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth * ItemCollectionViewCell.imageAspect)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
