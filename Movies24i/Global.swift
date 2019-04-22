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

    /// Colors palete
    enum Color: UInt32 {
        case text = 0x000000FF
        case white = 0xFFFFFFFF
        case clear = 0x00000000

        var color: UIColor {
            return UIColor(rgba: self.rawValue)
        }

        func dimColor(_ alpha: CGFloat = 0.5) -> UIColor {
            return color.withAlphaComponent(alpha)
        }
    }

    /// Fonts
    enum FontSize: CGFloat {
        case large = 25.0
        case heading = 15.0
        case regular = 14.0

        func font(_ bold: Bool = false) -> UIFont {
            return bold ? UIFont.boldSystemFont(ofSize: self.rawValue)
                : UIFont.systemFont(ofSize: self.rawValue)
        }

    }

    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

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
