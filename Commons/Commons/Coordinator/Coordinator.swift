//
//  Coordinator.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
        
    init(navigationController: UINavigationController)
    
    func start()
}

extension Coordinator {
    
    public static func instance(parent: Coordinator? = nil) -> Self {
        let navigationController = UINavigationController()
        let coordinator = Self(navigationController: navigationController)
        coordinator.parent = parent
        return coordinator
    }
    
    public func removeChild(_ childCoordinator: Coordinator?) {
        guard let childCoordinator = childCoordinator else { return }
        children.removeAll { child -> Bool in
            child === childCoordinator
        }
    }
    
}

