//
//  Endpoint.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias Headers = [String: String]

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var task: Task { get }
    var headers: Headers? { get }
}

public extension Endpoint {
    
    func urlRequest() throws -> URLRequest {
            var request = URLRequest(url: URL(endpoint: self))
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            
            switch task {
            case .requestPlain:
                return request
            case .requestJSONEncodable(let encodable):
                return try request.encoded(encodable: encodable)
            case .requestParameters(let parameters, let parameterEncoding):
                return try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
            }
        }
    
}
