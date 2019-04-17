//
//  Alertable.swift
//  MUIKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import UIKit
import MCoreKit

/// To provide the functionality of showing a popup on any screen
public protocol Alertable {
    /// Display a notification popup
    func alert(_ title: String?, message: String?, handler: (() -> Void)?)
    /// Display a dialog for confirmation
    func confirm(_ title: String?, message: String?, action: String, destructive: Bool, handler: (() -> Void)?)
    /// Display a popup asking for user input
    func prompt(_ title: String?, message: String?, handler: @escaping (String?) -> Void)
}

/// Provide default implementation of Alertable using `UIAlertController`
public extension Alertable where Self: UIViewController {

    func alert(_ title: String?, message: String?, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localize.System.ok, style: .default, handler: { _ in
            handler?()
        }))
        present(alert, animated: true, completion: nil)
    }

    func confirm(_ title: String?, message: String?, action: String, destructive: Bool = false, handler: (() -> Void)? = nil) {
        let confirm = UIAlertController(title: title, message: message, preferredStyle: .alert)
        confirm.addAction(UIAlertAction(title: action, style: destructive ? .destructive : .default, handler: { _ in
            handler?()
        }))
        confirm.addAction(UIAlertAction(title: Localize.System.cancel, style: .cancel))
        present(confirm, animated: true, completion: nil)
    }

    func prompt(_ title: String?, message: String?, handler: @escaping (String?) -> Void) {
        let prompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        prompt.addAction(UIAlertAction(title: Localize.System.cancel, style: .cancel))
        prompt.addAction(UIAlertAction(title: Localize.System.ok, style: .default, handler: { _ in
            handler(prompt.textFields?.first?.text)
        }))
        present(prompt, animated: true, completion: nil)
    }

}
