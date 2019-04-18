//
//  UIExtensions.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

/// Mapping modules to respective storyboards
extension MApp.Modules: Modularized {

    var storyboad: String {
        switch self {
        case .root:
            return MApp.Storyboard.main.rawValue
        }
    }

}
