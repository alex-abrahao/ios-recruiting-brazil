//
//  PopularsHeaderView.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

class PopularsHeaderView: UIView {
    
    // MARK: - Properties -
    // MARK: View
    internal var headlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        if #available(iOS 13.0, *) {
            label.font = UIFont.roundedBold(17)
        } else {
            // Fallback on earlier versions
            label.font = UIFont.bold(17)
        }
        label.accessibilityIdentifier = "headlineLabel"
        return label
    }()

    internal var callToActionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        if #available(iOS 13.0, *) {
            label.font = UIFont.roundedBold(27)
        } else {
            // Fallback on earlier versions
            label.font = UIFont.bold(27)
        }
        label.accessibilityIdentifier = "callToActionLabel"
        return label
    }()
    
    internal var gridButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "grid")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.accessibilityIdentifier = "gridButton"
        return button
    }()
    
    // MARK: - Init -
    override init(frame: CGRect) {

        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        self.accessibilityIdentifier = "PopularsHeaderView"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    /// Setup the view's UI
    func setupUI() {
        self.addSubview(headlineLabel)
        self.addSubview(callToActionLabel)
        self.addSubview(gridButton)
    }

    /// Setup the view's Constraints
    func setupConstraints() {
        setNeedsDisplay()

        headlineLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalTo(gridButton.snp.leading)
            make.bottom.equalTo(callToActionLabel.snp.top)
        }

        callToActionLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(headlineLabel)
        }
        
        gridButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
        }
    }
}
