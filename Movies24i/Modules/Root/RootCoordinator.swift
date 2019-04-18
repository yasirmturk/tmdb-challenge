//
//  RootCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class RootCoordinator: Coordinator {

    var children = [Coordinator]()
    var root: UIViewController

    var split: RootViewController? { return root as? RootViewController }

    weak var detail: DetailViewController?
    weak var detailNav: UINavigationController?

    init(_ rootController: UIViewController) {
        self.root = rootController
    }

    func start() {
        guard let split = split else { return }

        split.delegate = self

        let vc1 = MasterViewController.instantiate(MApp.Modules.root)
        vc1.coordinator = self
        let vc2 = DetailViewController.instantiate(MApp.Modules.root)
        vc2.navigationItem.leftBarButtonItem = split.displayModeButtonItem
        detail = vc2
        let vc2Nav = UINavigationController(rootViewController: vc2)
        detailNav = vc2Nav

        split.viewControllers = [
            UINavigationController(rootViewController: vc1),
            vc2Nav]
    }

    func showDetail(obj: NSDate) {
        guard let split = split else { return }
        guard let detail = detail, let detailNav = detailNav else { return }

        detail.detailItem = obj
        detail.navigationItem.leftBarButtonItem = split.displayModeButtonItem
        detail.navigationItem.leftItemsSupplementBackButton = true
        if split.viewControllers.count == 1 {
            split.showDetailViewController(detailNav, sender: self)
        }
    }

}

// MARK: - Split view

extension RootCoordinator: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}
