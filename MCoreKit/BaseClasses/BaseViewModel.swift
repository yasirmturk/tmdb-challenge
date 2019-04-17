//
//  BaseViewModel.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Providing utility for initialization setup of a ViewModel
open class BaseViewModel {

    public init() {
        prepare()
    }

    /// Override this method to provide custom initialization
    open func prepare() {
        // Default is a no-op
    }
}
