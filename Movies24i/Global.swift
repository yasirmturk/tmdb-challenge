//
//  Global.swift
//  Movies24i
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit

/// Providing global and static objects relevant to this App
struct MApp {

    /// List all the modules in the app
    enum Modules {
        case root
    }

    /// List all the storyboards in the app
    enum Storyboard: String {
        case main = "Main"
    }
}

/// Global Configuration
public struct MConfig {

    /// Setting default environment based on xcode config
    #if DEBUG
    public static let defaultEnvironment = Environment.development
    #elseif UAT
    public static let defaultEnvironment = Environment.staging
    #else
    public static let defaultEnvironment = Environment.production
    #endif

    struct Servers {
        static let api = TMDbAPIServer()
        static let media = TMDbMediaServer()

        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
}
