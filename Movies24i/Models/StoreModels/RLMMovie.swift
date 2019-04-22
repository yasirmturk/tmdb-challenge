//
//  RLMMovie.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import RealmSwift

/// Model for storing Movie
class RLMMovie: Object {
    @objc dynamic var id = 0
    @objc dynamic var title: String!
    @objc dynamic var poster: String!
    @objc dynamic var releaseDate: Date!
    @objc dynamic var overview: String!

    var genres = List<RLMGenre>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Adding realm support to movie

extension RLMMovie {

    convenience init(movie: Movie) {
        self.init(value: [
            "id": movie.id,
            "title": movie.title,
            "poster": movie.poster,
            "releaseDate": movie.releaseDate,
            "overview": movie.overview
            ])
        // Populate genres
        for genre in movie.genres {
            self.genres.append(RLMGenre(genre: genre))
        }
    }

    var model: Movie {
        return Movie(id: self.id,
                     title: self.title,
                     poster: self.poster,
                     genres: Array(self.genres.map { $0.model }),
                     releaseDate: self.releaseDate,
                     overview: self.overview)
    }

}
