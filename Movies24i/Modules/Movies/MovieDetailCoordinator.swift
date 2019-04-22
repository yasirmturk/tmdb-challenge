//
//  MovieDetailCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 20/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit

class MovieDetailCoordinator: Coordinator {

    // MARK: - Properties
    var children = [Coordinator]()
    var root: UIViewController!

    weak var viewModel: MovieDetailViewModel?

    init(_ controller: UIViewController) {
        self.root = controller
    }

    func start() {
        guard let root = root as? UINavigationController else { return }

        let vc = MovieDetailViewController.instantiate(Module.movies)
        let vm = MovieDetailViewModel(model: MovieModel())
        vm.delegate = self
        vc.viewModel = vm
        viewModel = vm

        root.viewControllers = [vc]
    }

    // MARK: - Detail operations

    func selectInitialMovie(_ movie: Movie) {
        guard let vm = viewModel else { return }
        if vm.selectedMovie == nil {
            vm.pushNext(movie: movie)
        }
    }

    func reloadMovieDetail(_ movie: Movie) {
        guard let vm = viewModel else { return }
        vm.pushNext(movie: movie)
    }
}

extension MovieDetailCoordinator: MovieDetailViewModelDelegate {

    func showTrailer(for movie: Movie) {
        
    }
}
