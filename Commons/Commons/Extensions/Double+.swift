//
//  Int+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 29/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public extension Double {
    
    func formatToMinutesAndSeconds() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter.string(from: date)
    }
    
}
