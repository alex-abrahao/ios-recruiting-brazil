//
//  Presenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

protocol Presenter: AnyObject {
    
    /**
     The view object that conforms to a `ViewDelegate` protocol.
     
     Send the updates to the view using this property.
     */
    var view: ViewDelegate? { get set }
    
    /**
     Do any steps to load the data.
     
     To be called by the view.
     */
    func loadData()
    
    /**
    Do any steps to update the data.
    
    To be called by the view.
    */
    func updateData()
}

extension Presenter {
    func updateData() {}
}
