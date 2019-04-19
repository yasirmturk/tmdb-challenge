//
//  Genre.swift
//  Movies24i
//
//  Created by Yasir M Turk on 19/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Defines the type of Movie returned from the API
struct Genre {

    // Primitive attributes
    let id: Int
    let name: String? = nil
}

/// Implementation of Decodable
extension Genre: Model { }
