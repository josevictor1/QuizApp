//
//  URLRequest+.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        do {
            let encodable = AnyEncodable(encodable)
            httpBody = try encoder.encode(encodable)
            
            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }
            
            return self
        } catch {
            throw NetworkError.encodableMapping(error)
        }
    }
    
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw NetworkError.parameterEncoding(error)
        }
    }
    
}
