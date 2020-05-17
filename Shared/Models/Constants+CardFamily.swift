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

        let color: Color
        let generation: Generation
    }
}

// Extension to aid reporting, error checking, sanity checking, etc
extension Constants.Family.Color {
    var expectedTotalCards: Int {
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
    var expectedTotalCards: Int {
        switch self {
        case .first:
            return 10
        case .second:
            return 11
        case .third:
            return 10
        case .fourth:
            return 8
        case .fifth:
            return 4
        }
    }
}

extension Constants.Family {
    /*
    private func internalCheck(for color: FamilyColor?, generation: Generation?) -> Int {
        if ((color != nil) && (generation != nil)) {
            return self.expectedTotalCards(for: color!, generation: generation!)
        }
        else if ((color != nil) && (generation == nil)) {
            return color!.expectedTotalCards
        } else if ((color == nil) && (generation != nil)) {
            return generation!.expectedTotalCards
        }
        return 0
    }*/
}


extension Constants.Family {

    func counterFor(color: FamilyColor, generation: FamilyGeneration) -> Int {
        switch color {
        case .green: // 20
            switch generation {
            case .first:
                return 4
            case .second:
                return 4
            case .third:
                return 4
            case .fourth:
                return 4
            case .fifth:
                return 4
            }
        case .red: // 13
            switch generation {
            case .first:
                return 3
            case .second:
                return 3
            case .third:
                return 3
            case .fourth:
                return 4
            default:
                return 0
            }

        case .yellow: // 7
            switch generation {
            case .first:
                return 2
            case .second:
                return 2
            case .third:
                return 3
            default:
                return 0
            }

        case .blue:
            switch generation {
            case .first:
                return 1
            case .second:
                return 2
            default:
                return 0
            }
        }
    }
}
