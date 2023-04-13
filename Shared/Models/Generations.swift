//
//  Generations.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

// Trains have a generation (first, second, third, etc)
public enum Generation: Int, Codable, CaseIterable, Equatable {
    case first = 1, second, third, fourth, fifth
}

// Stringify
extension Generation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .first: return "first"
        case .second: return "second"
        case .third: return "third"
        case .fourth: return "fourth"
        case .fifth: return "fifth"
        }
    }
}

// Comparsion
extension Generation {
    static public func > (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue > rhs.rawValue)
    }
    static public func < (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue < rhs.rawValue)
    }
    static public func == (lhs: Generation, rhs: Generation) -> Bool {
        return (lhs.rawValue == rhs.rawValue)
    }
}
