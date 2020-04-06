//
//  FeedVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher
import SnapKit

/// A basic View Controller to display a feed of movies
class FeedVC: UIViewController, FavoriteViewDelegate {
    
    // MARK: - Properties -
    var feedPresenter: FeedPresenter
    weak var selectionDelegate: MovieSelectionDelegate?
    
    /// Collection view's current delegate
    var collectionDelegate: FeedCollectionDelegate
    
    /// Collection view's current data source
    var collectionDataSource: FeedCollectionDataSource
    
    // MARK: View
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.accessibilityIdentifier = "feedCollectionView"
        view.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        view.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
        return view
    }()
    
    private(set) var errorView: ErrorView = ErrorView()
    
    /// An activity indicator to show when the view is loading
    let activityIndicator: UIActivityIndicatorView = {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            style = .whiteLarge
        } else {
            // Fallback on earlier versions
            style = .gray
        }
        let view = UIActivityIndicatorView(style: style)
        view.hidesWhenStopped = true
        view.accessibilityIdentifier = "activityIndicator"
        return view
    }()
    
    // MARK: - Init -
    init(presenter: FeedPresenter = FeedPresenter(),
         dataSource: FeedCollectionDataSource = FeedCollectionDataSource(),
         delegate: FeedCollectionDelegate = FeedCollectionDelegate()) {
        guard type(of: self) != FeedVC.self else {
            os_log("❌ - FeedVC instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `FeedVC` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        
        self.feedPresenter = presenter
        
        self.collectionDataSource = dataSource
        self.collectionDelegate = delegate
        
        super.init(nibName: nil, bundle: nil)
        
        if Logger.isLogEnabled {
            os_log("🎮 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
        
        feedPresenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if Logger.isLogEnabled {
            os_log("🎮 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
    
    // MARK: - Methods -
    func startLoading() {
        activityIndicator.startAnimating()
        feedCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
        feedCollectionView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedCollectionView.dataSource = collectionDataSource
        feedCollectionView.delegate = collectionDelegate
        
        collectionDataSource.favoritePressed = { [weak self] tag in
            self?.feedPresenter.favoriteStateChanged(tag: tag)
        }
        
        collectionDelegate.didSelectItem = { [weak self] item in
            self?.feedPresenter.selectItem(item: item)
        }
        
        feedPresenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedPresenter.updateData()
    }
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? FeedCollectionViewCell else {
            os_log("❌ - Unknown cell type %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            return
        }
        cell.isFavorite = isFavorite
    }
}

// MARK: - Feed View Delegate -
extension FeedVC: FeedViewDelegate {
    
    func reloadFeed() {
        DispatchQueue.main.async { [weak self] in
            self?.feedCollectionView.reloadData()
        }
    }
    
    func resetFeedPosition() {
        self.feedCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
              at: .top,
        animated: true)
    }
    
    func dataSource(movies: [Movie]) {
        collectionDataSource.movies = movies
        reloadFeed()
    }
    
    func navigateToDetail(movie: Movie) {
        selectionDelegate?.select(movie: movie)
    }
}
