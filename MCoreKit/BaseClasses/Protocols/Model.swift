//
//  Model.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Protocol model should atleast be Decodable
public protocol Model: Decodable { }

/// Utility alias to representing json data
public typealias JSON = [String: Any]
