//
//  Family.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

//typealias FamilyColor = Family.Color
//typealias FamilyGeneration = Family.Generation

protocol FamilyProtocol {
    var color: Family.Color { get }
    var generation: Family.Generation { get }
}

// `Family` constants
// A card "belongs" to a `family`
// A family is considered to be a `color (Int) and a `generation` (Int)
//
public struct Family {
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
