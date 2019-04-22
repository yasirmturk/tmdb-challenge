//
//  MovieDetailViewController.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import RxSwift
import RxCocoa
import AlamofireImage

class MovieDetailViewController: RxViewController, Storyboarded {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!

    // MARK: - Properties
    var viewModel: MovieDetailViewModel!

    // MARK: - Private fields

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    override func prepareView() {
        super.prepareView()

        title = .MovieDetail

        imageView.contentMode = .scaleAspectFill

        titleLabel.font = MApp.FontSize.large.font()

        genreTitleLabel.font = MApp.FontSize.heading.font(true)
        genreTitleLabel.text = .Genres
        dateTitleLabel.font = MApp.FontSize.heading.font(true)
        dateTitleLabel.text = .Date
        overviewTitleLabel.font = MApp.FontSize.heading.font(true)
        overviewTitleLabel.text = .Overview

        trailerButton.setTitleColor(MApp.Color.text.color, for: .normal)
        trailerButton.setTitle(.WatchTrailer, for: .normal)
    }

    override func prepareBinding() {
        super.prepareBinding()

        trailerButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.watchTrailer()
        }).disposed(by: bag)
    }

    override func prepareData() {
        super.prepareData()

        // Bind data
        viewModel.movie.flatMap({ Observable.from(optional: $0) })
            .subscribe(onNext: { [weak self] movie in
                self?.configureView(movie)
            }).disposed(by: bag)

        // Display error
        viewModel.errors.subscribe(onNext: { [weak self] error in
            self?.alert(.Movies24i, message: error.localizedDescription)
        }).disposed(by: bag)
    }

    func configureView(_ movie: Movie) {
        // Update the user interface for the detail item.
        titleLabel.text = movie.title
        if let poster = movie.posterURL() {
            imageView.af_setImage(withURL: poster, placeholderImage: UIImage(named: "mozima"))
        }
        genreLabel.text = movie.genres.compactMap({ $0.name }).joined(separator: ",")
        dateLabel.text = MApp.displayDateFormatter.string(from: movie.releaseDate)
        overviewTextView.text = movie.overview
    }

}
