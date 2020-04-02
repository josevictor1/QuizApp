//
//  UITableView+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 29/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        let bundle = Bundle(for: cell.self)
        let nib = UINib(nibName: "\(cell.self)", bundle: bundle)
        register(nib, forCellReuseIdentifier: "\(cell.self)")
    }
    
}
