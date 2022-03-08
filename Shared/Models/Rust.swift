//
//  Rust.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// Obsolescence
// In the game trains can be unavailable to purchase (not built) thru to rusted

enum Rust : NSInteger, Codable, CaseIterable {
    case notbuilt = -1, new = 0, rusting, rusted
}

// Stringify description
extension Rust: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .notbuilt:
                return "notbuilt"
            case .new:
                return "new"
            case .rusting:
                return "rusting"
            case .rusted:
                return "obsolete"
            }
        }
    }
}

extension Rust {
    mutating func age() {
        let a = type(of: self).allCases
        self = a[(a.firstIndex(of: self)! + 1) % a.count]
    }
}
