//
//  ServerInfo.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Network server information and configuration
public protocol ServerInfo {

    /// The server's base `URL`
    var baseURL: String { get }

    // More configuartion can be added
}

// MARK: - String Utility specific to Network service

/// String extensions to provide utility for Network
public extension String {

    /// HTTP method: GET
    static let HTTPGet = "GET"
    /// HTTP method: POST
    static let HTTPPost = "POST"

}
