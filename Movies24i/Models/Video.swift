//
//  Video.swift
//  Movies24i
//
//  Created by Yasir M Turk on 19/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Video sites
enum VideoSite: String {
    case youtube
}

/// Video sites
enum VideoType: String {
    case trailer = "Trailer"
    case teaser = "Teaser"
}

/// Defines the type of Movie Video returned from the API
struct Video {

    // Primitive attributes
    let id: String
    let key: String
    let name: String
    let site: VideoSite?
    let size: Int
    let type: VideoType?

}

/// Implementation of Decodable
extension Video: Model {

    enum CodingKeys: String, CodingKey {
        case id, key, name, site, size, type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        key = try container.decode(String.self, forKey: .key)
        name = try container.decode(String.self, forKey: .name)
        site = VideoSite(rawValue: try container.decode(String.self, forKey: .site))
        size = try container.decode(Int.self, forKey: .size)
        type = VideoType(rawValue: try container.decode(String.self, forKey: .type))
    }
}

/// To parse the API result from video list
struct VideoResult {
    let id: Int
    let results: [Video]
}

/// Implementation of Decodable
extension VideoResult: Model { }
