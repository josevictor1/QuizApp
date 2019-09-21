//
//  UIViewController+Instanciable.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol Instantiable {
    static func instantiate() -> Self
}

public extension Instantiable where Self: UIViewController  {
    
    static func instantiate() -> Self {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: "\(Self.self)", bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Initial view controller is not the type of \(Self.self)")
        }
        return viewController
    }
    
}

extension UIViewController: Instantiable { }
