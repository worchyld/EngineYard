//
//  Constants+Expected.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Used for internal checks and sanity checks

extension Constants {

struct Expected {
    var color: Family.Color?
    var generation: Family.Generation?

    private var totalCardsForColor: Int {
        guard let color = self.color else { return 0 }
        switch color {
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

    private var totalCardsForGeneration: Int {
        guard let generation = self.generation else { return 0 }
        switch generation {
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

    private var totalCardsForColorAndGeneration: Int {
        guard let color = self.color else {
            return 0
        }
        guard let generation = self.generation else {
            return 0
        }

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

    public var results: Int {
        if ((color != nil) && (generation != nil)) {
            return totalCardsForColorAndGeneration
        }
        else if ((color == nil) && (generation != nil)) {
            return totalCardsForGeneration
        } else if ((color != nil) && (generation == nil)) {
            return totalCardsForColor
        }
        else {
            return 0
        }
    }

}


} // :end extension
