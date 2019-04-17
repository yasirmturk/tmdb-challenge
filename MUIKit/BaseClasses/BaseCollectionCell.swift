//
//  BaseCollectionCell.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

/// Base class for UICollectionViewCell
open class BaseCollectionCell: UICollectionViewCell, ViewPreparable {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }

    /// Override point for custom UI setup
    public func prepareView() {
        // Default is a no-op
    }
}
