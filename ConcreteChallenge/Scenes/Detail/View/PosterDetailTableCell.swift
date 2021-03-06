//
//  PosterDetailTableCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

final class PosterDetailTableCell: BaseTableViewCell {
    
    // MARK: - Properties -
    /// Height / Width
    static let imageAspect: CGFloat = (1920/1280)
    
    // MARK: View
    let posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
        
    // MARK: - Methods -
    override func setupUI() {
        
        posterImageView.kf.indicatorType = .activity
        contentView.addSubview(posterImageView)
    }
    
    override func setupConstraints() {
        
        posterImageView.snp.makeConstraints { (make) in
            let imageWidth = UIScreen.main.bounds.width - 60
            make.center.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth * PosterDetailTableCell.imageAspect)
            make.top.equalToSuperview().offset(20).priority(999)
            make.bottom.equalToSuperview().inset(20).priority(999)
        }
        
        contentView.sizeToFit()
    }
    
    func makeErrorConstraints() {
        errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            let width = UIScreen.main.bounds.width - 40
            make.width.equalTo(width)
            make.height.equalTo(width * 9/16)
        }
    }
}

// MARK: - ErrorDelegate -
extension PosterDetailTableCell: ErrorDelegate {
    func displayError(_ type: ErrorMessageType) {
        
        errorView.displayMessage(type)
        
        guard errorView.superview == nil else { return }
        
        contentView.addSubview(errorView)
        
        makeErrorConstraints()
    }
    
    func hideError() {
        errorView.removeFromSuperview()
    }
}
