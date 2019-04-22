//
//  AppModules.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

/// List all the modules in the app
enum Module {
    case movies
}

/// List all the storyboards in the app
enum Storyboard: String {
    case main = "Main"
}

/// Mapping modules to respective storyboards
extension Module: Modularized {

    var storyboad: String {
        switch self {
        case .movies:
            return Storyboard.main.rawValue
        }
    }

}
