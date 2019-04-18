//
//  Storyboarded.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

/// To provide mechanism for UIViewController instantiate from a storyboard
protocol Storyboarded {
    /// Create instance and return same type
    static func instantiate(_ module: Modularized) -> Self
}

/// Providing default implementation for any UIViewController
extension Storyboarded where Self: UIViewController {

    /// By default the Storyboard ID should be same as the class name
    static func instantiate(_ module: Modularized) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: module.storyboad, bundle: Bundle.main)
        //swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
