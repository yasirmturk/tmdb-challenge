//
//  RLMGenre.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import RealmSwift

/// Model for storing genre
class RLMGenre: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Adding realm support to genre

extension RLMGenre {

    convenience init(genre: Genre) {
        self.init(value: ["id": genre.id])
        self.name = genre.name
    }

    var model: Genre {
        return Genre(id: self.id, name: self.name)
    }
}
