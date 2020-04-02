//
//  NetworkError.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case encodableMapping(Error)
    case parameterEncoding(Error)
    case underlying(Error, Response?)
}
