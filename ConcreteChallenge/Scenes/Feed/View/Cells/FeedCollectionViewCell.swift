//
//  FeedCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import SnapKit

class FeedCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties -
    // MARK: View
    let filmImageView: GradientImageView = {
        let view = GradientImageView(frame: .zero)
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.kf.indicatorType = .activity
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
        return button
    }()
    
    /// Changes the display image for the favorite button depending on the state
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(named: isFavorite ? "favoriteFull" : "favoriteEmpty"), for: .normal)
        }
    }
    
    // MARK: - Methods -
    override func setupUI() {
        
        // Make the button able to be pressed
        filmImageView.isUserInteractionEnabled = true
        
        contentView.addSubview(filmImageView)
        filmImageView.addSubview(titleLabel)
        filmImageView.addSubview(favoriteButton)
    }
    
    func makeErrorConstraints() {
        errorView.snp.makeConstraints { (make) in
            make.edges.equalTo(filmImageView)
        }
    }
}

// MARK: - ErrorDelegate -
extension FeedCollectionViewCell: ErrorDelegate {
    func displayError(_ type: ErrorMessageType) {
        
        errorView.displayMessage(type)
        
        guard errorView.superview == nil else { return }
        
        contentView.insertSubview(errorView, at: 0)
        
        makeErrorConstraints()
    }
    
    func hideError() {
        errorView.removeFromSuperview()
    }
}
