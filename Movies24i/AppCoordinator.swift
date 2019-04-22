//
//  AppCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import Reachability
import MaterialComponents

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

    let reachability = Reachability()
    static var connected = true

    init(_ window: UIWindow, start: Bool = false) {
        self.window = window
        if start { self.start() }
    }

    func start() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            showMoviesAndDetail()
        } else {
            showMovies()
        }

        prepareReachability()
    }

    /// Start catalogue
    func showMovies() {
        let nav = BaseNavigationController()
        let c = MovieCatalogueCoordinator(nav)
        c.start()
        children.append(c)
        root = nav
    }

    /// Start catalogue and details side by side
    func showMoviesAndDetail() {
        let split = MainSplitViewController()
        split.viewControllers = [BaseNavigationController(), BaseNavigationController()]
        root = split
    }

    /// Monitor the network connection
    func prepareReachability() {
        reachability?.whenReachable = { r in
            AppCoordinator.connected = r.connection != .none
            MDCSnackbarManager.show(MDCSnackbarMessage(text: .Connected))
        }

        reachability?.whenUnreachable = { r in
            AppCoordinator.connected = false
            MDCSnackbarManager.show(MDCSnackbarMessage(text: .ErrorNetwork))
        }

        do {
            try reachability?.startNotifier()
        } catch {
            MDCSnackbarManager.show(MDCSnackbarMessage(text: .ErrorReachability))
        }
    }

}
