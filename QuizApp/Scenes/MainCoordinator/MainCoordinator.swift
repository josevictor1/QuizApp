//
//  MainCoordinator.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var parent: Coordinator? = nil
    var children: [Coordinator] = []
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = KeyWordsViewController.instantiate()
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}
