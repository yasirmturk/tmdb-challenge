//
//  AppCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class AppCoordinator: Coordinator {

    var children = [Coordinator]()
    var root: UIViewController! {
        get {
            return window.rootViewController
        }
        set {
            window.rootViewController = newValue
        }
    }

    weak var window: UIWindow!

    init(_ window: UIWindow, start: Bool = false) {
        self.window = window
        if start { self.start() }
    }

    func start() {
        showMovies()
    }

    func showMovies() {
        let split = MainSplitViewController()
        split.viewControllers = [UINavigationController(), UINavigationController()]
        root = split
    }

}