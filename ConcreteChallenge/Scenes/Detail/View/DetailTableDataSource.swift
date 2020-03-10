//
//  DetailTableDataSource.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import os.log

final class DetailTableDataSource: NSObject {
    
    var displayData: [DetailInfoType] = []
    
}

extension DetailTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = self.displayData[indexPath.row]
        
        switch info {
        case .poster(let imageURL):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: info.identifier, for: indexPath) as? PosterDetailTableCell else {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            cell.textLabel?.text = title
            return cell
            
        case .year(let year):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            cell.textLabel?.text = year
            return cell
            
        case .genres(let genres):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            cell.textLabel?.text = genres
            return cell
            
        case .overview(let text):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultInfoTableCell.identifier, for: indexPath) as? DefaultInfoTableCell else {
                os_log("❌ - Unknown cell identifier %@", log: Logger.appLog(), type: .fault, "\(String(describing: self))")
                fatalError("Unknown identifier")
            }
            
            cell.textLabel?.text = text
            return cell
        }
    }
}
