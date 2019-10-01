//
//  KeyboardAvoidable.swift
//  Commons
//
//  Created by José Victor Pereira Costa on 24/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

public class KeyboardAvoidingHelper: KeyboardAvoidable {
    
    // MARK: - Properties
    
    private var didShow = false
    public var onShow: ((CGFloat) -> Void)?
    public var onHide: ((CGFloat) -> Void)?
    
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Logic
    
    public func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboadWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func keyboadWillShow(_ notification: Notification) {
        guard let keyboardFrame = extractKeyboardFrame(from: notification), !didShow else { return }
        didShow = !didShow
        onShow?(keyboardFrame.height)
    }
    
    @objc public func keyboardWillHide(_ notification: Notification) {
        guard let keyboardFrame = extractKeyboardFrame(from: notification), didShow else { return }
        didShow = !didShow
        onHide?(keyboardFrame.height)
    }
    
    private func extractKeyboardFrame(from notification: Notification) -> CGRect? {
        return  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
    
}
