//
//  MovieDetailViewModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit
import RxSwift

protocol MovieDetailViewModelDelegate: AnyObject {
    func showTrailer(for movie: Movie)
}

class MovieDetailViewModel: RxViewModel {

    // MARK: - Properties
    let model: MovieModel

    let movie = BehaviorSubject<Movie?>(value: nil)
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

    func watchTrailer() {
        guard let m = selectedMovie else { return }

        self.delegate?.showTrailer(for: m)
    }
}
