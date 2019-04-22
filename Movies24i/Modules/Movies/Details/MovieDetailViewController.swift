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

/// ViewController for the movie details
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

    /// ViewModel for the movie details
    var viewModel: MovieDetailViewModel!

    // MARK: - Private fields

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let nav = navigationController, !nav.viewControllers.contains(self) {
            // print("Popping out, time for cleanup")
            viewModel.cleanup()
        }
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

        // Bind watch trailer button tap
        trailerButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.startAnimating()
            self.viewModel.fetchVideos()
        }).disposed(by: bag)
    }

    override func prepareData() {
        super.prepareData()

        // Bind data
        viewModel.movie.flatMap({ Observable.from(optional: $0) })
            .subscribe(onNext: { [weak self] movie in
                self?.configureView(movie)
            }).disposed(by: bag)

        // Bind videos
        viewModel.videos.subscribe(onNext: { [weak self] videos in
            self?.stopAnimating()
            // Present list of videos to user
            // or
            // Auto pick first one
            guard let v = videos.first(where: { $0.site == .youtube }) else { return }
            // Proceed to player
            self?.viewModel.watchTrailer(v)
        }).disposed(by: bag)

        // Display error
        viewModel.errors.subscribe(onNext: { [weak self] error in
            self?.stopAnimating()
            self?.alert(.Movies24i, message: error.localizedDescription)
        }).disposed(by: bag)
    }

    /// Update the user interface for the detail item.
    func configureView(_ movie: Movie) {
        titleLabel.text = movie.title
        if let poster = movie.posterURL(for: .w780) {
            imageView.af_setImage(withURL: poster, placeholderImage: UIImage(named: "mozima"))
        }
        genreLabel.text = movie.genres.compactMap({ $0.name }).joined(separator: ",")
        dateLabel.text = MApp.displayDateFormatter.string(from: movie.releaseDate)
        overviewTextView.text = movie.overview
    }

}
