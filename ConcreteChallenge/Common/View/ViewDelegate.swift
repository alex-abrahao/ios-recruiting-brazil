//
//  ViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol ViewDelegate: AnyObject, ErrorDelegate {
    
    /// Do the necessary steps to inform the user that the view is loading
    func startLoading()
    
    /// Do the necessary steps to inform the user that the view has stopped loading
    func finishLoading()
    
    /// Tells the view to back to the previous view
    func exitView()
}
