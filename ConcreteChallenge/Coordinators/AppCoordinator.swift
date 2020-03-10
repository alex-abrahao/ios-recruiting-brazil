//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties -
    var window: UIWindow
    
    // MARK: Coordinator
    var rootViewController: UIViewController?
    var childCoordinators: [Coordinator] = []
    
    var parent: Coordinator? {
        // App Coordinator has no parent
        return nil
    }
    
    init(window: UIWindow) {
        
        self.window = window
    }
    
    func start() {
        
        let coordinators: [Coordinator] = [PopularsCoordinator(parent: self), FavoritesCoordinator(parent: self)]

        coordinators.forEach {
            childCoordinators.append($0)
            $0.start()
        }

        let controllers: [UIViewController] = coordinators.map {
            if let vc = $0.rootViewController {
                return vc
            }
            fatalError("Coordinator \(String(describing: $0)) had not started root controller properly")
        }
        
        let tabBarController = TabBarController()
        tabBarController.setViewControllers(controllers, animated: true)
        
        self.rootViewController = tabBarController
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
