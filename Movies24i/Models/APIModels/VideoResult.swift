//
//  VideoResult.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// To parse the API result from video list
struct VideoResult {
    let id: Int
    let results: [Video]
}

/// Implementation of Decodable
extension VideoResult: Model { }
