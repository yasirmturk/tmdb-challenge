//
//  MovieDetailCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 20/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class MovieDetailCoordinator: Coordinator {

    var children = [Coordinator]()
    var root: UIViewController!

    var detail: MovieDetailViewController? {
        return (root as? UINavigationController)?.viewControllers.first as? MovieDetailViewController
    }

    init(_ controller: UIViewController) {
        self.root = controller
    }

    func start() {
        guard let root = root as? UINavigationController else { return }

        let vc = MovieDetailViewController.instantiate(Module.movies)
        let vm = MovieDetailViewModel()
        vc.viewModel = vm
        vc.coordinator = self

        root.viewControllers = [vc]
    }

    func reloadMovieDetail(_ movie: Movie) {
        guard let detail = detail else { return }
        detail.detailItem = movie
    }
}
