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

final class DetailVC: BaseViewController {
    
    // MARK: - Properties -
    var detailPresenter: DetailPresenter? {
        return presenter as? DetailPresenter
    }
    
    /// Cell that displays the genres info, to be updated when necessary
    weak var genresCell: DefaultInfoTableCell?
    
    // MARK: View
    let detailTableView: UITableView = {
        let view = UITableView()
        view.layoutMargins = .zero
        view.isScrollEnabled = true
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.estimatedSectionHeaderHeight = 0
        view.showsVerticalScrollIndicator = false
        view.accessibilityIdentifier = "feedTableView"
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
        
        let button = UIBarButtonItem(image: UIImage(named: (detailPresenter?.isFavorite ?? false) ? "favoriteFull" : "favoriteEmpty"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(favoriteTapped(_:)))
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods -
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .white
        self.title = detailPresenter?.getBarTitle()
        self.navigationItem.rightBarButtonItem = favoriteButton
        
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    override func addSubviews() {
        self.view.addSubview(detailTableView)
    }
    
    override func setupConstraints() {
        
        detailTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func favoriteTapped(_ sender: UIBarButtonItem) {
        
        detailPresenter?.favoriteStateChanged()
    }
}

// MARK: - Detail View Delegate -
extension DetailVC: DetailViewDelegate {
    func setGenres(data: GenreViewData) {
        DispatchQueue.main.async { [weak self] in
            self?.genresCell?.textLabel?.text = data.genres
        }
    }
    
    func setFavorite(_ isFavorite: Bool, tag: Int? = nil) {
        let image = UIImage(named: isFavorite ? "favoriteFull" : "favoriteEmpty")
        favoriteButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(favoriteTapped(_:)))
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
}

// MARK: - TableView Data Source -
extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailPresenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let info = detailPresenter?.getDetailInfo(row: indexPath.row) else {
            os_log("❌ - Unknown presenter %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
            fatalError("Unknown Presenter")
        }
        
        switch info {
        case .poster(let imageURL):
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: info.identifier, for: indexPath) as? PosterDetailTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            cell.posterImageView.kf.indicatorType = .activity
            if let imageURL = imageURL {
                cell.posterImageView.kf.setImage(with: imageURL) { [weak cell] (result) in
                    switch result {
                    case .failure(let error):
                        cell?.displayError(.info("Image could not be downloaded"))
                        os_log("❌ - Image not downloaded %@", log: Logger.appLog(), type: .error, error.localizedDescription)
                    default:
                        return
                    }
                }
            } else {
                cell.displayError(.missing("No poster available 😭"))
            }
            return cell
            
        case .title(let title):
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            cell.textLabel?.text = title
            return cell
            
        case .year(let year):
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            cell.textLabel?.text = year
            return cell
            
        case .genres(let genres):
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            cell.textLabel?.text = genres
            self.genresCell = cell
            return cell
            
        case .overview(let text):
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            cell.textLabel?.text = text
            return cell
        }
    }
}

extension DetailVC: UITableViewDelegate {
    
}
