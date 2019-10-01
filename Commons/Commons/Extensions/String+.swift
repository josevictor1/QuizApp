//
//  String+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 30/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public extension String {
    
    func localized(tableName: String? = nil, bundle: Bundle = .main, comment: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: comment)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
