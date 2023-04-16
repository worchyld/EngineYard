//
//  Rust.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

// Rusting / Obsolescence
// In the game trains can be unavailable to purchase (not built) thru to rusted

protocol RustUseCases {
    mutating func rustify()
}

enum Rust: Int, Codable, CaseIterable, Equatable  {
    case notBuilt, hasInitialOrder, built, rusting, rusted
}

extension Rust : RustUseCases {
    mutating func rustify() {
        // set rusted as the default if it can't be aged further
        self = Rust(rawValue: rawValue + 1) ?? .rusted
    }
    
    public func isActiveButNotRusted() -> Bool {
        let rustValue = self.rawValue
        return (rustValue >= Rust.built.rawValue && rustValue <= Rust.rusting.rawValue)
    }
}
