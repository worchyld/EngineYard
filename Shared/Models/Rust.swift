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
    mutating func rustify()
}

enum Rust : NSInteger, Codable, CaseIterable, Equatable {
    case notBuilt = -1, active = 0, rusting, rusted
}

// Stringify description
extension Rust: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .notBuilt:
                return "notBuilt"
            case .active:
                return "active"
            case .rusting:
                return "rusting"
            case .rusted: // obsolete
                return "rusted"
            }
        }
    }
}

extension Rust : RustUseCases {
    mutating func rustify() {
        // set rusted as the default if it can't be aged further
        self = Rust(rawValue: rawValue + 1) ?? .rusted
    }
    
    public func isActiveButNotRusted() -> Bool {
        let rustValue = self.rawValue
        return (rustValue >= Rust.active.rawValue && rustValue <= Rust.rusting.rawValue)
    }
}
