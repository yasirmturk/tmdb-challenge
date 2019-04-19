//
//  NetworkEndpoint.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Network request parameter encoding types
public enum NetworkEncoding {
    /// URL or query string
    case url
    /// HTTP form post
    case form
    /// JSON Body
    case json
}

/// A dictionary of parameters to apply to a HTTP Request
public typealias Params = [String: Any]

/// A dictionary of headers to apply to a HTTP Request
public typealias Headers = [String: String]

// MARK: - Network Endpoints information and configuration

/// This defines the basic information of an endpoint
public protocol NetworkEndpoint {

    /// Base information about the server common for all endpoints
    var server: ServerInfo { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method to be used in the request.
    var httpMethod: String { get }

    /// The HTTP headers to be used in the request.
    var headers: Headers? { get }

    /// The parameters for the request
    var parameters: Params? { get }

    /// Type of encoding to use for params
    var encoding: NetworkEncoding { get }

}

/// Providing default implementation of Network endpoint
public extension NetworkEndpoint {

    /// Utility computed property to make the complete URL
    var endPoint: URL? {
        return URL(string: server.baseURL + path)
    }

    /// Default value for HTTP headers is json
    var headers: Headers? {
        return ["Content-type": "application/json"]
    }

}

/// This defines an endpoint of type GET
public protocol HTTPGetEndPoint: NetworkEndpoint { }

public extension HTTPGetEndPoint {

    /// Default value for HTTP method is GET
    var httpMethod: String { return .HTTPGet }

    /// Default parameters are most probably nil but can be set
    var parameters: Params? { return nil }

    /// Default encoding for a GET request
    var encoding: NetworkEncoding { return .url }

}

/// This defines an endpoint of HTTP/Form Post
public protocol HTTPPostEndPoint: NetworkEndpoint { }

/// Providing default values for HTTP/Form Post
public extension HTTPPostEndPoint {

    /// Default value for JSON Body is POST
    var httpMethod: String { return .HTTPPost }

    /// Default value for HTTP headers is json
    var headers: Headers? {
        return ["Content-type": "application/x-www-form-urlencoded"]
    }

    /// Default encoding for a POST request
    var encoding: NetworkEncoding { return .form }

}
