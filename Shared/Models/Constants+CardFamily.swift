//
//  Constants+CardFamily.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias FamilyColor = Constants.Family.Color
typealias FamilyGeneration = Constants.Family.Generation

protocol CardFamilyProtocol {
    var color: FamilyColor { get }
    var generation: FamilyGeneration { get }
}

// `Family` constants
// A card "belongs" to a `family`
// A family is considered to be a `color (Int) and a `generation` (Int)
//
extension Constants {

    // A card is "grouped by" Family
    public struct Family {
        enum Color: Int, CaseIterable {
            case green = 1
            case red
            case yellow
            case blue

            static let allRawValues = FamilyColor.green.rawValue...FamilyColor.blue.rawValue
        }

        public enum Generation: Int, CaseIterable {
            case first = 1
            case second
            case third
            case fourth
            case fifth

            static let allRawValues = FamilyGeneration.first.rawValue...FamilyGeneration.fifth.rawValue
        }
    }
}

// Extension to aid reporting, error checking, sanity checking, etc
extension Constants.Family.Color {
    var ExpectedTotalCards: Int {
        switch self {
        case .green:
            return 20
        case .red:
            return 13
        case .yellow:
            return 7
        case .blue:
            return 3
        }
    }
}

// Extension to aid reporting, error checking, sanity checking, etc
extension Constants.Family.Generation {
    var ExpectedTotalCards: Int {
        switch self {
        case .first:
            return 10
        case .second:
            return 11
        case .third:
            return 12
        case .fourth:
            return 8
        case .fifth:
            return 4
        }
    }
}
