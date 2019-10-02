//
//  Response.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public final class Response {
    
   /// The status code of the response.
    public let statusCode: Int
    
    /// The response data.
    public let data: Data
    
    /// The original URLRequest for the response.
    public let request: URLRequest?
    
    /// The HTTPURLResponse object.
    public let response: HTTPURLResponse?
    
    public init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    
}
