//
//  BaseViewController.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

class BaseViewController: UIViewController, ViewDelegate {
    
    // MARK: - Properties -
    /// View to display many kinds of error. Add this as a subview when needed.
    var errorView: ErrorView = ErrorView()
    
    // MARK: - Init -
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        guard type(of: self) != BaseViewController.self else {
            os_log("❌ - BaseViewController instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `BaseViewController` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        
        super.init(nibName: nil, bundle: nil)
        
        if Logger.isLogEnabled {
            os_log("🎮 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if Logger.isLogEnabled {
            os_log("🎮 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: View Setup
    /**
     This method calls the other view setup methods.
     
     - Important: Calling the superclass method is required
     */
    func setupUI() {
        
        addSubviews()
        setupConstraints()
    }
    
    /**
     Override this method to add the subviews of the Controller.
     
     Calling the superclass method is not needed.
     */
    func addSubviews() {}
    
    /**
     Override this method to add the constraints to the subviews of the Controller.
     
     Calling the superclass method is not needed.
     */
    func setupConstraints() {}

    // MARK: - ViewDelegate
    func startLoading() {}
    
    func finishLoading() {}
    
    func exitView() {
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func navigateTo(viewController: UIViewController) {
                
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - ErrorDelegate
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
