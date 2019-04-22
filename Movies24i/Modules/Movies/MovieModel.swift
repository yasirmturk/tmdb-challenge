//
//  MovieModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Model provider for the Movie store, could be network or storage
struct MovieModel: ModelStore {

    // MARK: - Properties

    let network = AlamofireProvider<TMDbMovieAPI>()
//    let stub = StubProvider<TMDbMovieAPI>()

    // MARK: - Methods

    ///
    func fetchPopular(onSuccess: @escaping (([Movie]) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchPopular(onSuccess: { r in
            r.results.isEmpty
                ? onError(TMDbAPIError(code: 199, message: .ErrorNotEnoughData))
                : onSuccess(r.results)
        }, onError: { err in
            onError(err)
        })
    }

    ///
    func fetchDetail(_ movie: Movie, onSuccess: @escaping ((Movie) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchDetails(movie.id, onSuccess: { movie in
            onSuccess(movie)
        }, onError: { err in
            onError(err)
        })
    }

    ///
    func fetchVideos(_ movie: Movie, onSuccess: @escaping (([Video]) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchVideos(movie.id, onSuccess: { r in
            r.results.isEmpty
                ? onError(TMDbAPIError(code: 199, message: .ErrorNotEnoughData))
                : onSuccess(r.results)
        }, onError: { err in
            onError(err)
        })
    }
}
