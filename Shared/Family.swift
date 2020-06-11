//
//  Family.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol FamilyDelegate {
    var category: Family.Category { get }
    var color: Family.Color { get }
    var generation: Family.Generation { get }
}

// In the game cards `belong` to a family
// A family is considered a color (Int) and a generation (Int)
// IE: Green 1st Generation, Red 2nd Generation, etc

public struct Family: FamilyDelegate {
    var category: Family.Category
    var color: Family.Color
    var generation: Family.Generation

    public enum Category: String {
        case passenger // maps to green
        case freight // maps to yellow
        case fast // maps to red
        case special // maps to blue
    }

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
        self.category = color.category
    }
}

extension Family.Color {
    var category: Family.Category {
        switch self {
        case .green:
            return .passenger
        case .yellow:
            return .freight
        case .red:
            return .fast
        case .blue:
            return .special
        }
    }
}

// Ordinal description extension
extension Family.Generation {
    var ordinal: String? {
        let number: NSNumber = NSNumber(integerLiteral: self.rawValue)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}
