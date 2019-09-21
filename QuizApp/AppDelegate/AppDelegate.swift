//
//  AppDelegate.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator.instance()
        window?.rootViewController = mainCoordinator?.navigationController
        mainCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}

