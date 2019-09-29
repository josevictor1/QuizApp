//
//  UIViewController+.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 22/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func presentAlert(title: String, message: String, action: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: action, style: .destructive) { [unowned self] _ in
            self.dismiss(animated: true, completion: completion)
        }
        alertController.addAction(action)
        navigationController?.present(alertController, animated: true)
    }

}
