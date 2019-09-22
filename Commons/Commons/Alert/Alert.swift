//
//  Alert.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 22/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public struct Alert {
    let title: String
    let message: String
    let action: String
    
    public init(title: String, message: String, action: String) {
        self.title = title
        self.message = message
        self.action = action
    }
}
