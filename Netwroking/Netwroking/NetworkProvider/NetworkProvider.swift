//
//  NetworkProvider.swift
//  Networking
//
//  Created by José Victor Pereira Costa on 01/10/19.
//  Copyright © 2019 José Victor Pereira Costa. All rights reserved.
//

import Foundation

public typealias Completion = (Result<Response, NetworkError>) -> Void

public protocol NetworkProviderType {
    func request(_ endpoint: Endpoint, completion: @escaping Completion)
}

public class NetworkProvider: NetworkProviderType {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(_ endpoint: Endpoint, completion: @escaping Completion) {
        do {
            let request = try endpoint.urlRequest()
            performRequest(request, endpoint: endpoint, completion: completion)
        } catch NetworkError.parameterEncoding(let error) {
            completion(.failure(.parameterEncoding(error)))
        } catch {
            completion(.failure(.underlying(error, nil)))
        }
    }

    private func performRequest(_ request: URLRequest, endpoint: Endpoint, completion: @escaping Completion) {
        switch endpoint.task {
        case .requestPlain, .requestJSONEncodable, .requestParameters:
            sendRequest(request, completion: completion)
        }
    }

    private func sendRequest(_ request: URLRequest, completion: @escaping Completion) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            let result = self.convertResponseToResult(response, request: request, data: data, error: error)
            completion(result)
        }
        dataTask.resume()
    }
    
    public func convertResponseToResult(_ response: HTTPURLResponse?, request: URLRequest?, data: Data?, error: Swift.Error?) ->
        Result<Networking.Response, NetworkError> {
            switch (response, data, error) {
            case let (.some(response), data, .none):
                let response = Networking.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                return .success(response)
            case let (.some(response), _, .some(error)):
                let response = Networking.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                let error = NetworkError.underlying(error, response)
                return .failure(error)
            case let (_, _, .some(error)):
                let error = NetworkError.underlying(error, nil)
                return .failure(error)
            default:
                let error = NetworkError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
                return .failure(error)
            }
    }
    
    public func requestDecodable<D: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<D, NetworkError>) -> Void) {
        let decoder = JSONDecoder()
        
        return request(endpoint, completion: { result in
            switch result {
            case .success(let response):
                do {
                    let result = try decoder.decode(D.self, from: response.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.underlying(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
