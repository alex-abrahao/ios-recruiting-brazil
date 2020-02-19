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
    
    private var client: MovieService = MovieClient()
    
    // MARK: - Methods -
    override func loadFeed() {
        view?.startLoading()
        client.getPopular(page: 1) { [weak self] (result: Result<[Movie], Error>) in
            
            self?.view?.finishLoading()
            
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
        
        client.getPopular(page: client.currentPage + 1) { [weak self] (result: Result<[Movie], Error>) in
            
            self?.view?.finishLoading()
            
            switch result {
            case .success(let movies):
                self?.movies.append(contentsOf: movies)
            case .failure(let error):
                os_log("❌ - Error loading movie feed: %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                self?.view?.displayError(.generic)
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
        favoriteService.checkFavorites(on: movies)
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
        
        client.search(text) { [weak self] (result: Result<[Movie], Error>) in
            
            self?.view?.finishLoading()
            
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.feedView.resetFeedPosition()
                if movies.isEmpty {
                    self?.view?.displayError(.missing("Your search of \"\(text)\" found nothing"))
                }
            case .failure(let error):
                os_log("❌ - Error searching movies: %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                self?.view?.displayError(.info("Error loading search results"))
            }
        }
    }
}
