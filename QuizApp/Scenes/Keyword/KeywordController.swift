//
//  KeywordController.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 02/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

protocol KeywordControllerProvider {
    func requestKeywords(completion: @escaping ((Result<Keywords, Error>) -> Void))
}

class KeywordController: KeywordControllerProvider {
    
    let service: KeywordServiceProvider
    
    init(service: KeywordServiceProvider = KeywordService()) {
        self.service = service
    }
    
    func requestKeywords(completion: @escaping ((Result<Keywords, Error>) -> Void)) {
        service.requestKeywords { result in
            switch result {
            case .success(let response):
                completion(.success(Keywords(response: response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
