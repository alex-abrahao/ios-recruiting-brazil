//
//  FeedPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

class FeedPresenter: Presenter, FavoriteHandler {
    
    // MARK: - Properties -
    weak var view: ViewDelegate?
    
    internal var feedView: FeedViewDelegate {
        guard let view = view as? FeedViewDelegate else {
            os_log("❌ - FeedPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FeedPresenter was given to the wrong view")
        }
        return view
    }
    
    internal var favoritesView: FavoriteViewDelegate {
        guard let view = view as? FavoriteViewDelegate else {
            os_log("❌ - FeedPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("FeedPresenter was given to the wrong view")
        }
        return view
    }
    
    var favoriteClient: FavoriteClientProtocol
    
    /// The movie data to be displayed
    internal var movies: [Movie] = [] {
        didSet {
            feedView.dataSource(movies: movies)
        }
    }
    
    // MARK: Computed
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: - Init -
    init(favoriteClient: FavoriteClientProtocol = FavoriteClient()) {
        guard type(of: self) != FeedPresenter.self else {
            os_log("❌ - FeedPresenter instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `FeedPresenter` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        self.favoriteClient = favoriteClient
        
        if Logger.isLogEnabled {
            os_log("🖥 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    deinit {
        if Logger.isLogEnabled {
            os_log("🖥 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - Methods -
    func loadData() {
        loadFeed()
    }
    
    func updateData() {
        favoriteClient.checkFavorites(on: movies)
        feedView.reloadFeed()
    }
    
    /**
     Override to do the necessary steps to load the feed data.
     */
    func loadFeed() {}
    
    func selectItem(item: Int) {
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return
        }
        
        let movie = movies[item]
        feedView.navigateToDetail(movie: movie)
    }
    
    // MARK: - Favorite handler
    func favoriteStateChanged(tag: Int?) {
        guard let item = tag else {
            os_log("❌ - Favorite had no tag", log: Logger.appLog(), type: .fault)
            return
        }
        
        guard item < self.numberOfItems else {
            os_log("❌ - Number of items > number of movies", log: Logger.appLog(), type: .fault)
            return
        }
        
        let movie = movies[item]
        movie.isFavorite = !movie.isFavorite
        favoritesView.setFavorite(movie.isFavorite, tag: item)
        if movie.isFavorite {
            favoriteClient.setFavorite(movie: movie)
        } else {
            favoriteClient.removeFavorite(movie: movie)
        }
    }
}
