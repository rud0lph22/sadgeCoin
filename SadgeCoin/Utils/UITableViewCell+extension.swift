//
//  UITableView+extension.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

