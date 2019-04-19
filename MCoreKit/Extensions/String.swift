//
//  String.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Adding common functionality to String class
public extension String {

    // MARK: - for Non-localized string constants

    /// Get Empty String
    static let Empty = ""
    /// Identifier for CoreKit
    static let MCoreDomain = "com.yasirmturk.MCoreKit"

    // MARK: - Computed properties for Localized string constants

    /// Get project localized string
    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}

/// Other extensions
public extension String {

    /// Utility to encode for query string
    var queryEscaped: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}

/// Provides way to check empty without unwrapping
public extension Optional where Wrapped == String {

    /// Checks to see whether the optional string is nil or empty ("")
    var isEmpty: Bool {
        return self?.isEmpty ?? true
    }

    /// Return the actual string or empty if nil
    var orEmpty: String {
        return self ?? .Empty
    }

    /// Get a trimmed value of string
    var trimmed: String {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines) ?? .Empty
    }

}
