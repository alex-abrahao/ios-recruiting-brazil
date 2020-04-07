//
//  FeedCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 13/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import os.log

class FeedCollectionViewCell: UICollectionViewCell, ViewCode {
    
    // MARK: - Properties -
    // MARK: View
    let filmImageView: GradientImageView = {
        let view = GradientImageView(frame: .zero)
        view.layer.cornerRadius = 15.0
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.kf.indicatorType = .activity
        view.accessibilityIdentifier = "filmImageViewFeedCell"
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        label.accessibilityIdentifier = "titleLabelFeedCell"
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteEmpty"), for: .normal)
        button.accessibilityIdentifier = "favoriteButtonFeedCell"
        return button
    }()
    
    private(set) lazy var errorView: ErrorView = ErrorView()
    
    /// Changes the display image for the favorite button depending on the state
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(UIImage(named: isFavorite ? "favoriteFull" : "favoriteEmpty"), for: .normal)
        }
    }
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        if Logger.isLogEnabled {
            os_log("🏻 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if Logger.isLogEnabled {
            os_log("🏻 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - Methods -
    func makeErrorConstraints() {
        errorView.snp.makeConstraints { (make) in
            make.edges.equalTo(filmImageView)
        }
    }
    
    // MARK: - ViewCode -
    func buildViewHierarchy() {
        contentView.addSubview(filmImageView)
        filmImageView.addSubview(titleLabel)
        filmImageView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        fatalError("FeedCell subclasses should implement \(#function)")
    }
    
    func setupAdditionalConfiguration() {
        filmImageView.isUserInteractionEnabled = true
        layer.masksToBounds = true
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
