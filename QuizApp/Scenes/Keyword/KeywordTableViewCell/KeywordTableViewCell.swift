//
//  KeywordTableViewCell.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 29/09/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(with keyword: String) {
        keywordLabel.text = keyword
    }
}
