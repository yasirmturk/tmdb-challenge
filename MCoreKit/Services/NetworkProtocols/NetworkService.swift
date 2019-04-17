//
//  NetworkService.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// To provide the functionality which actually handles the network calls
public protocol NetworkService: AnyObject {

    /// Associated API Endpoint
    associatedtype Target: NetworkEndpoint

    /// Session configuration can be set for this API
    var config: URLSessionConfiguration? { get set }

    /// actual method that handles the network call and relay the response back after parsing json
    func fetch(_ target: Target, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask?

    // More attributes can be added later as needed
}
