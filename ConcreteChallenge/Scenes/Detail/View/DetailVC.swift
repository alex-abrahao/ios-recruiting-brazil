//
//  DetailVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log
import Kingfisher
import SnapKit

final class DetailVC: UIViewController {
    
    // MARK: - Properties -
    var detailPresenter: DetailPresenter
    var tableDataSource: DetailTableDataSource
    
    // MARK: View
    let detailTableView: UITableView = {
        let view = UITableView()
        view.layoutMargins = .zero
        view.isScrollEnabled = true
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.estimatedSectionHeaderHeight = 0
        view.showsVerticalScrollIndicator = false
        view.accessibilityIdentifier = "detailTableView"
        view.rowHeight = UITableView.automaticDimension
        view.sectionHeaderHeight = 0
        view.showsVerticalScrollIndicator = false
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.register(PosterDetailTableCell.self, forCellReuseIdentifier: PosterDetailTableCell.identifier)
        view.register(DefaultInfoTableCell.self, forCellReuseIdentifier: DefaultInfoTableCell.identifier)
        return view
    }()
    
    lazy var favoriteButton: UIBarButtonItem = {
        
        let button = UIBarButtonItem(image: UIImage(named: detailPresenter.isFavorite ? "favoriteFull" : "favoriteEmpty"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(favoriteTapped(_:)))
        button.accessibilityIdentifier = "favoriteBarButtonItem"
        return button
    }()
    
    private(set) lazy var errorView: ErrorView = ErrorView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init -
    init(movie: Movie,
         presenter: DetailPresenter? = nil,
         dataSource: DetailTableDataSource = DetailTableDataSource()) {
        
        if let presenter = presenter {
            self.detailPresenter = presenter
        } else {
            self.detailPresenter = DetailPresenter(movie: movie)
        }
        
        tableDataSource = dataSource
        
        super.init(nibName: nil, bundle: nil)
        
        if Logger.isLogEnabled {
            os_log("🎮 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
        
        detailPresenter.view = self
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        detailTableView.dataSource = tableDataSource
        
        detailPresenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func favoriteTapped(_ sender: UIBarButtonItem) {
        
        detailPresenter.favoriteStateChanged()
    }
}

extension DetailVC: ViewCode {
    func buildViewHierarchy() {
        self.view.addSubview(detailTableView)
    }
    
    func setupConstraints() {
        
        detailTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        self.title = detailPresenter.getBarTitle()
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
}

// MARK: - Detail View Delegate -
extension DetailVC: DetailViewDelegate {    
    func setFavorite(_ isFavorite: Bool, tag: Int? = nil) {
        let image = UIImage(named: isFavorite ? "favoriteFull" : "favoriteEmpty")
        favoriteButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(favoriteTapped(_:)))
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    func reloadData(info: [DetailInfoType]) {
        tableDataSource.displayData = info
        detailTableView.reloadData()
    }
}
