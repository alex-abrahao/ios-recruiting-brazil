//
//  FavoritesCoordinator.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 03/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    
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
        
        let favoritesVC = FavoritesVC()
        favoritesVC.selectionDelegate = self
        
        let navController = NavigationController(rootViewController: favoritesVC)
        navController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favoriteFull"), tag: 1)
        self.rootViewController = navController
    }
}

extension FavoritesCoordinator: MovieSelectionDelegate {
    
    func select(movie: Movie) {
        let detailVC = DetailVC(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
