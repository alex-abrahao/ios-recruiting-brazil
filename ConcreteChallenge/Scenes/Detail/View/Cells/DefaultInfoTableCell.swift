//
//  DefaultInfoTableCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

final class DefaultInfoTableCell: UITableViewCell {
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if Logger.isLogEnabled {
            os_log("🔲 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
        
        let fontSize: CGFloat = 15
        if #available(iOS 13.0, *) {
            textLabel?.font = UIFont.rounded(fontSize)
        } else {
            textLabel?.font = UIFont.regular(fontSize)
        }
        textLabel?.textColor = Colors.almostBlack
        textLabel?.numberOfLines = 0
        accessibilityIdentifier = "DefaultInfoTableCell"
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if Logger.isLogEnabled {
            os_log("🔲 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }
}
