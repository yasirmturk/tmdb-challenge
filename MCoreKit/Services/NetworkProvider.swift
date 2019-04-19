//
//  NetworkProvider.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Default network provider base class implemented using URLSession
open class NetworkProvider<Target: NetworkEndpoint>: NetworkService {

    public var config: URLSessionConfiguration? {
        didSet {
            if let config = config {
                session = URLSession(configuration: config)
            }
        }
    }

    /// URLSession can be set
    public var session: URLSession

    public init(with config: URLSessionConfiguration? = nil) {
        self.config = config
        self.session = URLSession(configuration: config ?? URLSessionConfiguration.default)
    }

    public init(session: URLSession) {
        self.config = session.configuration
        self.session = session
    }

    public func fetch(_ target: Target, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        guard let url = target.endPoint else {
            return nil
        }

        // Compose the URLRequest
        var request = URLRequest(url: url)
        // Compose the request params
        if let params = target.parameters {
            switch target.encoding {
            case .url:
                request.queryString = params.queryString()
            case .form:
                request.httpBody = params.queryString().data(using: .utf8)
            case .json:
                request.httpBody = params.encode()
            }
        }
        //
        request.httpMethod = target.httpMethod
        // Set request specific headers
        for (k, v) in target.headers ?? [:] {
            request.setValue(v, forHTTPHeaderField: k)
        }

        // Initiate the request and return Data or Error
        let task = session.dataTask(with: request) { data, _, error in
            completion(data, error)
        }
        task.resume()
        return task
    }

}
