//
//  Coding.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Extension to allow deserialization of object from JSON data
extension Data {

    /// Try to deserialize directly from JSON data
    func decode<T: Decodable>(type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(MConfig.Servers.dateFormatter)
        return try decoder.decode(type, from: self)
    }
}
