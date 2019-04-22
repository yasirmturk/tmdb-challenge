//
//  MovieCatalogueViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import RxSwift
import RxCocoa

class MovieCatalogueViewController: RxTableController, Storyboarded {

    // MARK: - Properties
    var viewModel: MovieCatalogueViewModel!

    var objects = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController?.isCollapsed ?? false
        super.viewWillAppear(animated)
    }

    override func prepareView() {
        super.prepareView()

        title = .MovieCatalogue

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: .PullToLoad)

        tableView.refreshControl = refreshControl
        tableView.rowHeight = 100.0
    }

    override func prepareBinding() {
        super.prepareBinding()

        // Generate event for reload
        refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [unowned self] in
                self.viewModel.fetch()
                //                self.viewModel.events.onNext(.reload)
            }).disposed(by: bag)

        tableView.rx.modelSelected(Movie.self).subscribe(onNext: { [unowned self] model in
            self.viewModel.selectMovie(model)
            //            self.viewModel.events.onNext(.selectMovie(model))
        }).disposed(by: bag)
    }

    override func prepareData() {
        super.prepareData()

        startAnimating()
        viewModel.fetch()

        // Hide spinner on response
        viewModel.movies.subscribe(onNext: { [weak self] _ in
            self?.refreshControl?.endRefreshing()
            self?.stopAnimating()
        }).disposed(by: bag)
        // Bind to the tableview
        viewModel.movies.catchErrorJustReturn([])
            .bind(to: tableView.rx.items(cellIdentifier: MovieCell.reuseIdentifier, cellType: MovieCell.self)) { [weak self] idx, movie, cell in
                cell.movie = movie
//                if self?.tableView.indexPathForSelectedRow == nil {
//                    self?.tableView.selectRow(at: IndexPath(row: idx, section: 0), animated: true, scrollPosition: .none)
//                    self?.viewModel.selectMovie(movie)
//                }
            }.disposed(by: bag)
        // Display error
        viewModel.errors.subscribe(onNext: { [weak self] error in
            self?.alert(.Movies24i, message: error.localizedDescription)
        }).disposed(by: bag)
    }

}
