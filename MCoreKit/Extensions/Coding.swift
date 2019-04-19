//
//  Coding.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Extension to allow deserialization of object from JSON data
public extension Decodable {

    /// Try to deserialize directly from JSON data
    static func decode(data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

/// Encodable Extension to allow serialization to JSON objects
public extension Encodable {

    /// Quickly try to encode to JSON-ed Data
    func encodeToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    /// Quickly try to serialize direcly to JSON objects
    func encode() -> [String: Any]? {
        guard let data = try? encodeToData() else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    /// Quickly convert raw Data to json dictionary
    func dictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

/// Encode JSON objects to Data
public extension Dictionary {

    func queryString() -> String {
        return map { k, v in
            return "\(k)".queryEscaped.orEmpty + "=" + "\(v)".queryEscaped.orEmpty
        }.joined(separator: "&")
    }

    /// Quickly encode json dictionary to JSON-ed Data
    func encode() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
