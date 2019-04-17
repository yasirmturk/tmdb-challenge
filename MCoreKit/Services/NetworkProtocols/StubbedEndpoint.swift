//
//  StubbedEndpoint.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Provide Stubbed responses for any Endpoint
public protocol StubbedEndpoint: NetworkEndpoint {

    /// Read from file or return hard coded response here
    var data: Data? { get }

    /// Return appropriate error
    var error: Error? { get }
}
