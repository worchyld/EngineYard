//
//  Generation.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// Locomotive generation
enum Generation: NSInteger, Codable, CaseIterable {
    case first = 1, second, third, fourth, fifth
}

// Ordinal description extension
extension Generation {
    var ordinalFormat: String? {
        let number: NSNumber = NSNumber(integerLiteral: self.rawValue)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}

// Stringify description
extension Generation: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .first: return "first"
            case .second: return "second"
            case .third: return "third"
            case .fourth: return "fourth"
            case .fifth: return "fifth"
            }
        }
    }
}

extension Generation : Equatable {
    static func > (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue > rhs.rawValue)
    }
    static func < (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue < rhs.rawValue)
    }
    static func == (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue == rhs.rawValue)
    }
}
