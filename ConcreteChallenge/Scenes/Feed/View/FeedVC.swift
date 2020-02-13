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
class FeedVC: BaseViewController, FavoriteViewDelegate {
    
    // MARK: - Properties -
    var feedPresenter: FeedPresenter? {
        return presenter as? FeedPresenter
    }
    
    /// Collection view's current delegate
    var collectionDelegate: FeedCollectionViewDelegateFlowLayout = GridCollectionViewDelegate()
    
    /// Collection view's current data source
    var collectionDataSource: FeedCollectionViewDataSource = GridCollectionViewDataSource()
    
    // MARK: View
    let feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        view.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
        return view
    }()
    
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
        return view
    }()
    
    // MARK: - Init -
    override init(presenter: Presenter) {
        guard type(of: self) != FeedVC.self else {
            os_log("❌ - FeedVC instanciated directly", log: Logger.appLog(), type: .fault)
            fatalError(
                "Creating `FeedVC` instances directly is not supported. This class is meant to be subclassed."
            )
        }
        super.init(presenter: presenter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()

        view.backgroundColor = .white

        collectionDelegate.feedPresenter = feedPresenter
        collectionDataSource.feedPresenter = feedPresenter
        feedCollectionView.dataSource = collectionDataSource
        feedCollectionView.delegate = collectionDelegate
    }
    
    override func startLoading() {
        activityIndicator.startAnimating()
        feedCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
    }
    
    override func finishLoading() {
        activityIndicator.stopAnimating()
        feedCollectionView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedPresenter?.updateData()
    }
    
    func setFavorite(_ isFavorite: Bool, tag: Int?) {
        guard let item = tag, let cell = feedCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? FeedCollectionViewCell else {
            os_log("❌ - Unknown cell type %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            return
        }
        cell.isFavorite = isFavorite
    }
    
    // MARK: Button methods
    @objc func favoriteTapped(_ sender: UIButton) {
        feedPresenter?.favoriteStateChanged(tag: sender.tag)
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
}
