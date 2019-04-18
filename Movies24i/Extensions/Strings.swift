//
//  Strings.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Utility extension to provide constants etc.
extension String {
    // Default Domain for this app
    static let AppDomain = "com.yasirmturk.Movies24i"

    //
    static let Movies24i = "Movies 24i".localized

    // Error messages
    static let UnableToInitialize = "Unable to initialize the module %@".localized
    static let ErrorAPI = "The api is not working".localized
    static let ErrorClient = "The request is not valid".localized
    static let ErrorData = "The api sent invalid data".localized
    static let ErrorResponse = "The api sent invalid response".localized
}
