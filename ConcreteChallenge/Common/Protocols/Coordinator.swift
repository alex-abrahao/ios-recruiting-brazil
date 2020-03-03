//
//  Coordinator.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {

    var rootViewController: UIViewController? { get }
    var childCoordinators: [Coordinator] { get set }
    
    /**
     The parent `Coordinator`.
     
     - Important: Should be `weak` on the coordinators expected to have parents.
     */
    var parent: Coordinator? { get }
    
    func start()
}

extension Coordinator {
    
    func resignControl() {
        
        parent?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator) {
        
        var indexToRemove: Int = -1
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            indexToRemove = index
            break
        }
        
        if indexToRemove != -1 {
            childCoordinators.remove(at: indexToRemove)
        }
    }
}
