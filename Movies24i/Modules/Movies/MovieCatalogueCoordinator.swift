//
//  MovieCatalogueCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 20/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class MovieCatalogueCoordinator: Coordinator {

    var children = [Coordinator]()
    var root: UIViewController!

    init(_ controller: UIViewController) {
        self.root = controller
    }

    func start() {
        guard let root = root as? UINavigationController else { return }

        let vc = MovieCatalogueViewController.instantiate(Module.movies)
        let vm = MovieCatalogueViewModel(model: MovieModel())
        vc.viewModel = vm
        vm.delegate = self
        vc.coordinator = self

        root.viewControllers = [vc]
    }

    func showMovieDetail(_ movie: Movie) {
        // Reload data to detail VC
        guard let m = children.first as? MovieDetailCoordinator else { return }
        m.reloadMovieDetail(movie)

        // Push detail VC if not already showing
        guard let split = root.splitViewController else { return }
        if split.viewControllers.count == 1 {
            split.showDetailViewController(m.root, sender: split)
        }
    }
}

extension MovieCatalogueCoordinator: MovieCatalogueViewModelDelegate {

    func didSelect(_ movie: Movie) {
        showMovieDetail(movie)
    }
}
