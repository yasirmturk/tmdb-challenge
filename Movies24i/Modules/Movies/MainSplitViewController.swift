//
//  MainSplitViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit

class MainSplitViewController: UISplitViewController, Storyboarded {

    var catalogue: MovieCatalogueCoordinator!
    var detail: MovieDetailCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .primaryOverlay
        delegate = self

        catalogue = MovieCatalogueCoordinator(viewControllers[0])
        catalogue.start()

        detail = MovieDetailCoordinator(viewControllers[1])
        detail.start()

        catalogue.children.append(detail)
    }

}

// MARK: - Split view

extension MainSplitViewController: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? MovieDetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}
