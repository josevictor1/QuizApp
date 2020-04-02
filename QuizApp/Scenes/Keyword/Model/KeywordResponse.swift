//
//  KeywordResponse.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 02/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct KeywordResponse: Decodable {
    let question: String
    let answer: [String]
}
