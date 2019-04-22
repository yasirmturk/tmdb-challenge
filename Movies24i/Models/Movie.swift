//
//  Movie.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

/// Defines the type of Movie returned from the API
struct Movie {

    // Primitive attributes
    let id: Int
    let title: String
    let poster: String
    let genres: [Genre]
    let releaseDate: Date
    let overview: String

}

extension Movie {
    // Computed attributes

    // Methods
    func posterURL(for size: PosterSize = .w500) -> URL? {
        return URL(string: size.rawValue + poster,
                   relativeTo: MConfig.Servers.media.url)
    }
}

/// Implementation of Decodable
extension Movie: Model {

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case poster = "poster_path"
        case genreIDs = "genre_ids"
        case genres = "genres"
        case releaseDate = "release_date"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        poster = try container.decode(String.self, forKey: .poster)
        if let genreIDs = try? container.decode([Int].self, forKey: .genreIDs) {
            genres = genreIDs.map { Genre(id: $0, name: nil) }
        } else {
            genres = try container.decode([Genre].self, forKey: .genres)
        }
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        overview = try container.decode(String.self, forKey: .overview)
    }
}
