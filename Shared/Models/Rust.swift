//
//  Rust.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation


// Obsolescence
enum Rust : NSInteger, Codable, CaseIterable {
    case new = 0, rusting, rusted
}

// Stringify description
extension Rust: CustomStringConvertible {
    var description: String {
        get {
            switch self {
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
