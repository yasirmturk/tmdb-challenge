//
//  BaseControl.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

/// Base UIControl class
open class BaseControl: UIControl, ViewPreparable {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }

    /// Override this method to provide custom UI setup
    open func prepareView() {
        // Default is a no-op
    }

}
