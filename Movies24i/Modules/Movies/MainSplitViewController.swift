//
//  MainSplitViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

/// Split ViewController used on iPad only but could be used on any device
class MainSplitViewController: UISplitViewController, Storyboarded {

    // MARK: - Properties
    var catalogue: MovieCatalogueCoordinator!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // preferredDisplayMode = .allVisible
        delegate = self

        catalogue = MovieCatalogueCoordinator(viewControllers[0])
        catalogue.start()
        catalogue.prepareMovieDetail(viewControllers[1])
    }

}

// MARK: - Split view

extension MainSplitViewController: UISplitViewControllerDelegate {

    // Do not need this for ipad but kept for reference
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondary = secondaryViewController as? UINavigationController else { return false }
        guard let top = secondary.topViewController as? MovieDetailViewController else { return false }
        guard top.viewModel.selectedMovie != nil else {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}
