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

    //    let stub = StubProvider<TMDbMovieAPI>()

    let network = AlamofireProvider<TMDbMovieAPI>()

    let store = DataStoreProvider()

    // MARK: - Methods

    /// Only list movie method supports offline support for now
    func fetchPopular(onSuccess: @escaping (([Movie]) -> Void), onError: @escaping ((Error) -> Void)) {
        if AppCoordinator.connected {
            // Provide from online source
            TMDbMovieService(network).fetchPopular(onSuccess: { [weak store] r in
                if r.results.isEmpty {
                    onError(TMDbAPIError.emptyData)
                } else {
                    // Save for offline usage
                    store?.storeMovies(r.results)
                    onSuccess(r.results)
                }
            }, onError: { err in
                onError(err)
            })
        } else {
            // Provide from offline source
            let results = store.fetchPopular()
            results.isEmpty
                ? onError(TMDbAPIError.emptyData)
                : onSuccess(Array(results.map({ $0.model })))
        }

    }

    /// Provides movie details from an online source
    func fetchDetail(_ movie: Movie, onSuccess: @escaping ((Movie) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchDetails(movie.id, onSuccess: { movie in
            onSuccess(movie)
        }, onError: { err in
            onError(err)
        })
    }

    /// Provides videos details from an online source
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
