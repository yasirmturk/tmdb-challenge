//
//  ModelStore.swift
//  MCoreKit
//
//  Created by Yasir M Turk on 17/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import Foundation

/// Protocol for a ModelStore that should have a network service
public protocol ModelStore {
    associatedtype SVC: NetworkService
    var network: SVC { get }
}
