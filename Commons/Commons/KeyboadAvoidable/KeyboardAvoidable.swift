//
//  KeyboardAvoidable.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public protocol KeyboardAvoidable: AnyObject {
    
    var onShow: ((CGFloat) -> Void)? { get set }
    var onHide: ((CGFloat) -> Void)? { get set }
    
    func register()
    func keyboadWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
}
