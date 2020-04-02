//
//  KeywordTextFieldDelegate.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 29/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

extension KeywordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
