//
//  MovieDetailViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class MovieDetailViewController: UIViewController, Storyboarded {

    var coordinator: MovieDetailCoordinator?
    var viewModel: MovieDetailViewModel!

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.title
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Movie Details"

        prepareNavigationItem()
        configureView()
    }

    func prepareNavigationItem() {
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    var detailItem: Movie? {
        didSet {
            // Update the view.
            configureView()
        }
    }

}
