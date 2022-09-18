//
//  Rust.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// Obsolescence
// In the game trains can be unavailable to purchase (not built) thru to rusted

protocol RustUseCases {
    mutating func age()
}

enum Rust : NSInteger, Codable, CaseIterable {
    case notBuilt = -1, new = 0, rusting, rusted
}

// Stringify description
extension Rust: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .notBuilt:
                return "notBuilt"
            case .new:
                return "new"
            case .rusting:
                return "rusting"
            case .rusted: // obsolete
                return "rusted"
            }
        }
    }
}

extension Rust : RustUseCases {
    mutating func age() {
        // set rusted as the default if it can't be aged further
        self = Rust(rawValue: rawValue + 1) ?? .rusted
    }
}
