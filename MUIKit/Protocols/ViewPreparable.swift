//
//  ViewPreparable.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Providing a prepare method on load of any UI
internal protocol ViewPreparable {
    // Use this method configure UI on load
    func prepareView()
}
