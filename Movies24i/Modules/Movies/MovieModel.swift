//
//  MovieModel.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

struct MovieModel: ModelStore {

    let network = AlamofireProvider<TMDbMovieAPI>()

    func fetchPopular(onSuccess: @escaping (([Movie]) -> Void), onError: @escaping ((Error) -> Void)) {
        TMDbMovieService(network).fetchPopular(onSuccess: { movieResult in
            onSuccess(movieResult.results)
        }, onError: { err in
            onError(err)
        })
    }
}
