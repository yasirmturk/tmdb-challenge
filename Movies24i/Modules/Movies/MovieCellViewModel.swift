//
//  MovieCellViewModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit
import RxSwift

class MovieCellViewModel: RxViewModel {

    let movie: BehaviorSubject<Movie>!

    init(movie: Movie) {
        self.movie = BehaviorSubject<Movie>(value: movie)
        super.init()
    }

}
