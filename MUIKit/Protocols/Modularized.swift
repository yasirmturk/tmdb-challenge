//
//  Modularized.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// To support de-coupling of the app
public protocol Modularized {
    /// Each module of the app can be mapped with a storyboard
    var storyboad: String { get }
}
