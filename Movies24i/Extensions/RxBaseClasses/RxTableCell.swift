//
//  RxTableCell.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import RxSwift

/// Reactive Rx base class for UITableViewCell
class RxTableCell: BaseTableCell {
    ///
    let bag = DisposeBag()
}
