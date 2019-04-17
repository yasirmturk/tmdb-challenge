//
//  String.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit
import MCoreKit

/// Adding common functionality to String class
public extension String {

    /// Get system localized string
    var system: String {
        return Bundle(for: UIApplication.self).localizedString(forKey: self, value: nil, table: nil)
    }

}

/// Extension for system defined localized strings
public extension Localize {

    /// iOS defined localized string constants
    enum System {
        public static let ok = "Ok".system
        public static let cancel = "Cancel".system
        public static let done = "Done".system
        public static let search = "Search".system
    }

}
