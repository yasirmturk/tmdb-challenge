//
//  MovieService.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// TMDb Movie service can use this to call the apis
struct TMDbMovieService<S: NetworkService> where S.Target == TMDbMovieAPI {

    /// Network injection could be Alamofire or Stub network
    let network: S

    ///
    init(_ network: S) {
        self.network = network
    }

    /// Information about popular movies should be retrieved from /movie/popular endpoint.
    func fetchPopular(onSuccess: @escaping ((MovieResult) -> Void), onError: @escaping ((Error) -> Void)) {
        _ = network.fetch(.popular) { data, error in
            let result = TMDbAPIResult<MovieResult>(data, error)
            switch result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onError(error)
            }
        }
    }

    /// Retrieving movie details should be done using /movie/<id> endpoint.
    func fetchDetails(_ id: Int, onSuccess: @escaping ((Movie?) -> Void), onError: @escaping ((Error) -> Void)) {
        _ = network.fetch(.movieDetails(id)) { data, error in
            let result = TMDbAPIResult<Movie>(data, error)
            switch result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onError(error)
            }
        }
    }

    // Retrieving movie videos
    func fetchVideos(_ id: Int, onSuccess: @escaping ((VideoResult) -> Void), onError: @escaping ((Error) -> Void)) {
        _ = network.fetch(.movieVideos(id)) { data, error in
            let result = TMDbAPIResult<VideoResult>(data, error)
            switch result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onError(error)
            }
        }
    }

}
