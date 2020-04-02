//
//  KeywordService.swift
//  QuizApp
//
//  Created by José Victor Pereira Costa on 02/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Networking

protocol KeywordServiceProvider {
    func requestKeywords(completion: @escaping ((Result<KeywordResponse, NetworkError>) -> Void))
}

class KeywordService: KeywordServiceProvider {
    
    let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func requestKeywords(completion: @escaping ((Result<KeywordResponse, NetworkError>) -> Void)) {
        
        let endpoint = KeywordEndpoint()
        
        networkProvider.requestDecodable(endpoint) { (result: Result<KeywordResponse, NetworkError>)  in
            completion(result.mapError{ $0 })
        }
    }
    
}
