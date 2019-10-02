//
//  Keyword.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 02/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct Keywords {
    var question: String
    var answer: [String: String]
    
    init(response: KeywordResponse) {
        self.question = response.question
        self.answer = response.answer.reduce(into: [String: String]()) {
            $0[$1] = $1.capitalizingFirstLetter()
        }
    }
    
}
