//
//  Shift.swift
//  EngineYard
//
//  Created by Amarjit on 11/10/2022.
//

import Foundation

public enum ShiftError : Error {
    case fromCardMustBeAvailable
    case toCardMustBeAvailable
    case mustBePositive(units: Int)
    case toCardMustBeHigherGeneration
    case toCardHasRusted
    case fromCardHasRusted
}

class Shift {
    static func costToShift(units: Int, from: Card, to: Card) -> Int {
        guard units.isPositive else {
            return 0
        }
        guard let from = from.loco else {
            return 0
        }
        guard let to = to.loco else {
            return 0
        }
        guard to.generation > from.generation else {
            return 0
        }
        let cost = (to.productionCost * units)
        return cost
    }
}
