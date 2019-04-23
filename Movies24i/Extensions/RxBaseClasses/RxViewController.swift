//
//  RxViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import RxSwift
import NVActivityIndicatorView

/// Reactive Rx base class for UIViewController
class RxViewController: BaseViewController, NVActivityIndicatorViewable {
    ///
    let bag = DisposeBag()
    ///
    //    var viewModel: T!
}

/// Reactive Rx base class for UITableViewController
class RxTableController: BaseTableViewController, NVActivityIndicatorViewable {
    ///
    let bag = DisposeBag()

    override func prepareData() {
        super.prepareData()

        tableView.dataSource = nil
        tableView.delegate = nil
    }
}
