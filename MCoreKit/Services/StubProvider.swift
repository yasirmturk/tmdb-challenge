//
//  StubProvider.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Stub service provider, can be used to return stubbed responses
public final class StubProvider<Target: StubbedEndpoint>: NetworkService {

    public var config: URLSessionConfiguration?

    public init() { }

    public func fetch(_ target: Target, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        // Return data or error from Stubbed Endpoint
        completion(target.data, target.error)
        return nil
    }

}
