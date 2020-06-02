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
    let color: Color
    let generation: Generation

    enum Color: Int, CaseIterable {
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
}
