//
//  PopularsCoordinator.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class PopularsCoordinator: Coordinator {
    
    // MARK: - Properties -
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    // MARK: Coordinator
    var rootViewController: UIViewController?
    var childCoordinators: [Coordinator] = []
    weak var parent: Coordinator?
    
    // MARK: - Init -
    init(parent: Coordinator? = nil) {
        self.parent = parent
    }
    
    // MARK: - Methods -
    func start() {
        
        let popularsVC = PopularsVC()
        popularsVC.selectionDelegate = self
        
        let navController = NavigationController(rootViewController: popularsVC)
        navController.tabBarItem = UITabBarItem(title: "Popular", image: #imageLiteral(resourceName: "star"), tag: 0)
        self.rootViewController = navController
    }
}

extension PopularsCoordinator: MovieSelectionDelegate {
    
    func select(movie: Movie) {
        let detailVC = DetailVC(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}