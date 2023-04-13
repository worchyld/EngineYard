//
//  Generations.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

// Trains have a generation (first, second, third, etc)
enum Generation: Int, Codable, CaseIterable, Equatable {
    case first = 1, second, third, fourth, fifth
    
    static let allCases: AllCases = [
        .first, .second, .third, .fourth, .fifth
    ]
}

// Stringify
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

// Comparsion
extension Generation {
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
