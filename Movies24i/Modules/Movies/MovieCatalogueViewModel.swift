//
//  MovieCatalogueViewModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit
import RxSwift

protocol MovieCatalogueViewModelDelegate: AnyObject {
    func didLoadMovies(_ movies: [Movie])
    func didSelect(_ movie: Movie)
}

class MovieCatalogueViewModel: RxViewModel {

//    enum Event {
//        case reload
//        case selectMovie(_ movie: Movie)
//    }

    // MARK: - Properties
    let model: MovieModel

    let movies = PublishSubject<[Movie]>()
    let errors = PublishSubject<Error>()
//    let events = PublishSubject<Event>()

    weak var delegate: MovieCatalogueViewModelDelegate?

    // MARK: - Methods
    init(model: MovieModel) {
        self.model = model
        super.init()
    }

    override func prepare() {
        super.prepare()

//        events.subscribe(onNext: { [unowned self] e in
//            switch e {
//            case .reload: self.fetch()
//            case .selectMovie(let m): self.delegate?.didSelect(m)
//            }
//        }).disposed(by: bag)
    }

    func fetch() {
        model.fetchPopular(onSuccess: { [weak self] movies in
            self?.delegate?.didLoadMovies(movies)
            self?.movies.onNext(movies)
            }, onError: { [weak self] error in
                self?.errors.onNext(error)
        })
    }

    func selectMovie(_ movie: Movie) {
        self.delegate?.didSelect(movie)
    }

}
