//
//  MovieResult.swift
//  Movies24i
//
//  Created by Yasir M Turk on 19/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// To parse the API result from movie list
struct MovieResult {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
}

/// Implementation of Decodable
extension MovieResult: Model {

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        results = try container.decode([Movie].self, forKey: .results)
    }

}
