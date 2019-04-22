//
//  DataStoreProvider.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import RealmSwift

//swiftlint:disable force_try

/// Realm data store provider for offline support
class DataStoreProvider {

    /// save the movie to offline store
    func insertMovie(_ movie: Movie) {
        let rlmMovie = RLMMovie(movie: movie)
        insert { realm in
            realm.add(rlmMovie, update: true)
        }
    }

    /// fetch from database
    func fetchPopular() -> Results<RLMMovie> {
        return try! Realm().objects(RLMMovie.self)
    }

    /// Dump the data asyncronously
    func storeMovies(_ movies: [Movie]) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            for m in movies {
                try! realm.write {
                    realm.add(RLMMovie(movie: m), update: true)
                }
            }
        }
    }

}

// MARK: - Short hand methods for realm operations
extension DataStoreProvider {

    func insert(_ block: ((_ realm: Realm) -> Void)) {
        let realm = try! Realm()
        try! realm.write {
            block(realm)
        }
    }

    /**
     - parameter block: The block containing actions to perform.
     */
    func update(_ block: (() -> Void)) {
        let realm = try! Realm()
        try! realm.write {
            block()
        }
    }

    /**
     - parameter object: The object to delete.
     */
    func delete(_ object: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }

}

/// Setting up default realm configuration
extension DataStoreProvider {

    func clearRealmDB() {
        let realm = try! Realm()
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }

    static func prepareDefaultRealm() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 1
        config.objectTypes = [
            RLMGenre.self,
            RLMMovie.self
        ]
        config.migrationBlock = { migration, oldSchemaVersion in

        }
        #if DEBUG
        config.deleteRealmIfMigrationNeeded = true
        #endif
        Realm.Configuration.defaultConfiguration = config
    }

}
