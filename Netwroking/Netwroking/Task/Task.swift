//
//  Task.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

/// Represents an HTTP task.
public enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: Parameters, parameterEnconding: ParameterEncoding)
}
