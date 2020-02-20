//
//  DetailPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class DetailPresenter: BasePresenter {
    
    // MARK: - Properties -
    /// The movie to display the details
    private let movie: Movie
    
    private var detailView: DetailViewDelegate {
        guard let view = view as? DetailViewDelegate else {
            os_log("❌ - DetailPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("DetailPresenter was given to the wrong view")
        }
        return view
    }
    
    private var movieService: MovieService
    private var favoriteService: FavoriteService
    private var genreService: GenreService
    
    private lazy var displayData: [DetailInfoType] = [
        .poster(imageURL: ImageEndpoint.image(width: 500, path: movie.posterPath).completeURL),
        .title(movie.title),
        .year(movieYear),
        .genres(self.genresText),
        .overview(text: movie.overview)
    ]
    
    private var genres: [Genre] = [] {
        didSet {
            detailView.reloadData(info: displayData)
        }
    }
    
    var genresText: String {
        var completeGenres: String = ""
        genres.forEach { (genre) in
            completeGenres += genre.name
            if let lastGenre = genres.last, lastGenre.id != genre.id {
                completeGenres += ", "
            }
        }
        return completeGenres != "" ? completeGenres : "No known genres"
    }
    
    var numberOfRows: Int {
        return displayData.count
    }
    
    var isFavorite: Bool {
        return movie.isFavorite
    }
    
    private var movieYear: String {
        let year = movie.releaseDate.prefix(4)
        return "Year: " + String(year)
    }
    
    // MARK: - Init -
    init(movie: Movie,
         movieService: MovieService = MovieClient(),
         favoriteService: FavoriteService = FavoriteClient(),
         genreService: GenreService = GenreClient()) {
        self.movie = movie
        self.movieService = movieService
        self.favoriteService = favoriteService
        self.genreService = genreService
        super.init()
    }
    
    // MARK: - Methods -
    override func loadData() {
        getGenres()
    }
    
    private func getGenres() {
        // Searchs locally before
        if let genreList = genreService.getGenreList(from: movie.genreIDs) {
            self.genres = genreList
        } else {
            // Had one or more genres not locally found.
            // Needs to update the local list.
            movieService.getGenreList { [weak self] (result: Result<[Genre], Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let genreList):
                    let matchingGenres = genreList.filter { self.movie.genreIDs.contains($0.id) }
                    self.genres = matchingGenres
                case .failure(let error):
                    os_log("❌ - Error loading genres: %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                }
            }
        }
    }
    
    func getBarTitle() -> String {
        return "Movie"
    }
}

extension DetailPresenter: FavoriteHandler {
    func favoriteStateChanged(tag: Int? = nil) {
        
        movie.isFavorite = !movie.isFavorite
        detailView.setFavorite(movie.isFavorite, tag: nil)
        if movie.isFavorite {
            favoriteService.setFavorite(movie: movie)
        } else {
            favoriteService.removeFavorite(movie: movie)
        }
    }
}
