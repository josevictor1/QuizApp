//
//  UITextField+.swift
//  UIComponents
//
//  Created by José Victor Pereira Costa on 21/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomTextField: UITextField {
    
    @IBInspectable var insetX: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var insetY: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX , dy: insetY)
    }
}

