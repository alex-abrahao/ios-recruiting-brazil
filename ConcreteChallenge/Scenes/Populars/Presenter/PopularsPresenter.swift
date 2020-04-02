//
//  PopularsPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 15/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class PopularsPresenter: FeedPresenter {
    
    // MARK: - Properties -
    private var isSearching: Bool = false
    
    private var movieClient: MovieClientProtocol = MovieClient()
    
    // MARK: - Init -
    init(movieClient: MovieClientProtocol = MovieClient(),
         favoriteClient: FavoriteClientProtocol? = nil) {
        self.movieClient = movieClient
        
        if let favoriteClient = favoriteClient {
            super.init(favoriteClient: favoriteClient)
        } else if let movieClient = movieClient as? MovieClient {
            super.init(favoriteClient: movieClient.favoriteClient)
        } else {
            super.init()
        }
    }
    
    // MARK: - Methods -
    override func loadFeed() {
        view?.startLoading()
        movieClient.getPopular(page: 1) { [weak self] (result: Result<[Movie], Error>) in
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.finishLoading()
            }
            
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                os_log("❌ - Error loading movie feed: %@", log: Logger.appLog(), type: .fault, error.localizedDescription)
                self?.view?.displayError(.generic)
            }
        }
    }
    
    /// Load more items for the infinite scrolling feed.
    func loadMoreItems() {
        
        guard !isSearching else { return }
        view?.startLoading()
        
        movieClient.getPopular(page: movieClient.currentPage + 1) { [weak self] (result: Result<[Movie], Error>) in
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.finishLoading()
            }
            
            switch result {
            case .success(let movies):
                self?.movies.append(contentsOf: movies)
            case .failure(let error):
                os_log("❌ - Error loading movie feed: %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.displayError(.generic)
                }
            }
        }
    }
    
    func getHeaderData() -> PopularHeaderViewData {
        
        // TODO: Localize
        return PopularHeaderViewData(title: "Popular Movies",
                                  greeting: "Today's",
                                  searchBarPlaceholder: "Looking for a movie?")
    }
    
    /// Do any steps to update the displayed data
    override func updateData() {
        favoriteClient.checkFavorites(on: movies)
        feedView.reloadFeed()
    }
    
    /// Execute commands to return to the previous state and end a search.
    private func endSearching() {
        
        if isSearching {
            view?.hideError()
            loadFeed()
            feedView.resetFeedPosition()
        }
        isSearching = false
    }
    
    /**
     Search a movie from some text.
     - Parameter text: The text to be searched.
     */
    func searchMovie(_ text: String?) {
        view?.hideError()
        
        guard let text = text, text != "" else {
            endSearching()
            return
        }
        
        isSearching = true
        
        view?.startLoading()
        
        movieClient.search(text) { [weak self] (result: Result<[Movie], Error>) in
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.finishLoading()
            }
            
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async { [weak self] in
                    self?.feedView.resetFeedPosition()
                    if movies.isEmpty {
                        self?.view?.displayError(.missing("Your search of \"\(text)\" found nothing"))
                    }
                }
            case .failure(let error):
                os_log("❌ - Error searching movies: %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.displayError(.info("Error loading search results"))
                }
            }
        }
    }
}
