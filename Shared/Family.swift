//
//  Family.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol FamilyDelegate {
    var color: Family.Color { get }
    var generation: Family.Generation { get }
}

// In the game cards `belong` to a family
// A family is considered a color (Int) and a generation (Int)
// IE: Green 1st Generation, Red 2nd Generation, etc

public struct Family: FamilyDelegate {
    var color: Family.Color
    var generation: Family.Generation

    public enum Color: Int, CaseIterable {
        case green = 1
        case red
        case yellow
        case blue

        static let allRawValues = Family.Color.green.rawValue...Family.Color.blue.rawValue
    }

    public enum Generation: Int, CaseIterable {
        case first = 1
        case second
        case third
        case fourth
        case fifth

        static let allRawValues = Family.Generation.first.rawValue...Family.Generation.fifth.rawValue
    }

    init(color: Family.Color, generation: Family.Generation) {
        self.color = color
        self.generation = generation
    }
}

extension Family: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color.hashValue)
        hasher.combine(generation.hashValue)
    }
}

//extension Family: Equatable {
////    public static func == (lhs: Family, rhs: Family) -> Bool {
////        return ( (lhs.color == rhs.color) && (lhs.generation == rhs.generation) )
////    }
//}

// Ordinal description extension
extension Family.Generation {
    var ordinal: String? {
        let number: NSNumber = NSNumber(integerLiteral: self.rawValue)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}

// Description extension
extension Family : CustomStringConvertible {
    public var description: String {
        let colorAsString = String(describing: self.color)
        let generationAsString = String(describing: self.generation.ordinal ?? "0" ) + " Generation"
        return colorAsString + generationAsString
    }
}
