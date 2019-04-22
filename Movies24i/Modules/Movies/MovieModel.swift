//
//  MovieModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

struct MovieModel: ModelStore {

    // MARK: - Properties
    let network = AlamofireProvider<TMDbMovieAPI>()

    // MARK: - Methods
    func fetchPopular(onSuccess: @escaping (([Movie]) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchPopular(onSuccess: { movieResult in
            onSuccess(movieResult.results)
        }, onError: { err in
            onError(err)
        })
    }

    func fetchDetail(_ movie: Movie, onSuccess: @escaping ((Movie) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchDetails(movie.id, onSuccess: { movie in
            onSuccess(movie)
        }, onError: { err in
            onError(err)
        })
    }
}
