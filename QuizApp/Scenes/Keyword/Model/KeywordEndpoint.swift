//
//  KeywordResponseEndpoint.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 02/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

struct KeywordEndpoint: Endpoint {
    
    var baseURL: URL {
        return URL(string: "https://codechallenge.arctouch.com")!
    }
    var path: String {
        return "/quiz/1"
    }
    var method: Networking.Method {
        return .get
    }
    var task: Task {
        return .requestPlain
    }
    var headers: Headers? {
        return nil
    }
}
