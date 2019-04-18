//
//  Coordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

/// Using this protocol can provide de-coupling of navigation
public protocol Coordinator: AnyObject {

    // associatedtype RootController: UIViewController

    /// List all the sub-coordinators
    var children: [Coordinator] { get set }
    /// Provide a root to perform navigations
    var root: UIViewController { get set }

    /// Boot up the current coordinator
    func start()
}

/////
//public protocol Coordinated {
//    ///
//    associatedtype CDR: Coordinator
//    ///
//    var coordinator: CDR? { get set }
//}
