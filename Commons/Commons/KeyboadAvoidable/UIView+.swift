//
//  KeyboardAvoidable.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension UIView: KeyboardAvoidable {
    
    //var didShow = false
    
    public func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func keyboadWillShow(_ notification: Notification) {
        guard let keyboardFrame = extractKeyboardFrame(from: notification) else { return }
        let height = keyboardFrame.height
        setBottomConstraint(with: height)
        frame.origin.y -= height
        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc public func keyboardWillHide(_ notification: Notification) {
        
    }
    
    private func extractKeyboardFrame(from notification: Notification) -> CGRect? {
        return  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
    
    private func setBottomConstraint(with height: CGFloat) {
        constraints.forEach { constraint in
            if constraint.firstAttribute == .bottom || constraint.firstAttribute == .bottomMargin {
                constraint.constant = height
            }
        }
    }
    
}
