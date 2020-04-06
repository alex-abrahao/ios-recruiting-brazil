//
//  UIViewController+ErrorDelegate.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 06/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

extension ErrorDelegate where Self: UIViewController {
    
    func displayError(_ type: ErrorMessageType) {
        
        errorView.displayMessage(type)
        
        guard errorView.superview == nil else { return }
        
        view.addSubview(errorView)
        makeErrorConstraints()
    }
    
    func hideError() {
        errorView.removeFromSuperview()
    }
    
    // MARK: Other error methods
    /**
     Setup the `errorView` constraints at the center of the screen.
     
     Override to display the error view elsewhere.
     */
    func makeErrorConstraints() {
        errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            let width = UIScreen.main.bounds.width - 40
            make.width.equalTo(width)
            make.height.equalTo(width * 9/16)
        }
    }
}
