//
//  TMDbAPIResult.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

enum TMDbAPIResult<D: Model> {
    case success(D)
    case failure(error: Error)

    init(_ data: Data?, _ error: Error?) {
        guard let data = data else {
            self = .failure(error: error ?? TMDbAPIError.noData)
            return
        }

        // Try to parse error model first because native response does not
        // provide http errors
        if let error = (try? data.decode(type: TMDbAPIError.self)) ?? error {
            self = .failure(error: error)
            return
        }

        do {
            let result = try data.decode(type: D.self)
            self = .success(result)
        } catch {
            self = .failure(error: error)
        }
    }

}
