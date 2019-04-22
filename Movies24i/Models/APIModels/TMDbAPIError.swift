//
//  TMDbAPIError.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Error protocol
protocol MError: LocalizedError {
    var code: Int { get }
    var message: String { get }
}

/// Model for TMDb API errors
struct TMDbAPIError: MError {
    var code: Int
    var message: String

    var errorDescription: String? { return message }

    static let noData = TMDbAPIError(code: -1, message: .ErrorData)
    static let invalidResponse = TMDbAPIError(code: -1, message: .ErrorResponse)
    static let emptyData = TMDbAPIError(code: 199, message: .ErrorNotEnoughData)
}

// Implementing decodable mapping
extension TMDbAPIError: Model {

    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
    }
}
