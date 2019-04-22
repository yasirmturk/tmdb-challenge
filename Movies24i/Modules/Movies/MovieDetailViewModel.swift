//
//  MovieDetailViewModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit
import RxSwift

/// Events generated from the Movie details ViewModel
protocol MovieDetailViewModelDelegate: AnyObject {
    func showTrailer(for video: Video)
    func viewWillDismiss()
}

/// ViewModel class for movie details
class MovieDetailViewModel: RxViewModel {

    // MARK: - Properties

    /// Model for the movie
    let model: MovieModel

    let movie = BehaviorSubject<Movie?>(value: nil)
    let videos = PublishSubject<[Video]>()
    let errors = PublishSubject<Error>()

    weak var delegate: MovieDetailViewModelDelegate?

    var selectedMovie: Movie? {
        return try? movie.value()
    }

    // MARK: - Methods

    init(model: MovieModel) {
        self.model = model
        super.init()
    }

    func pushNext(movie: Movie) {

        self.movie.onNext(movie)

        model.fetchDetail(movie, onSuccess: { [weak self] movie in
            self?.movie.onNext(movie)
            }, onError: { [weak self] err in
                self?.errors.onNext(err)
        })
    }

    func fetchVideos() {
        guard let m = selectedMovie else { return }

        model.fetchVideos(m, onSuccess: { [weak self] videos in
            self?.videos.onNext(videos)
        }, onError: { [weak self] err in
            self?.errors.onNext(err)
        })
    }

    func watchTrailer(_ video: Video) {
        self.delegate?.showTrailer(for: video)
    }

    func cleanup() {
        self.delegate?.viewWillDismiss()
    }
}
