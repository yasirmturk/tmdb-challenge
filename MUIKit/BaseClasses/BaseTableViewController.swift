//
//  BaseTableViewController.swift
//  MUIKit
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

open class BaseTableViewController: UITableViewController, ViewPreparable, DataPreparable {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        prepareView()

        prepareBinding()

        prepareData()
    }

    /// Override this method to provide UI setup
    open func prepareView() {
        // Default is a no-op
    }

    /// Override point for Event binding
    open func prepareBinding() {
        // Default is a no-op
    }

    /// Override point to provide Data loading and instance state setup
    open func prepareData() {
        // Default is a no-op
    }

}

extension BaseTableViewController: Alertable { }
