//
//  ShiftProduction.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum ShiftErrorDelegate : Error {
    case sameCard
    case sameGeneration
    case downStream
    case productionCostError
    case doNotOwnOriginCard
    case doNotOwnDestinationCard
    case alreadyAtTail
    case unknownCardError
    case mustBePositive
    case notEnoughUnits
    case notEnoughMoney
    case handIsEmpty
    case invalidPlayer
}

extension ShiftErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .sameCard:
            return NSLocalizedString("Cannot shift production to the same card", comment: "Shifting error: Same card")
        case .sameGeneration:
            return NSLocalizedString("Cannot shift production to the same generation", comment: "Shifting error: Same generation")
        case .downStream:
            return NSLocalizedString("Cannot shift production to cards with lower generation", comment: "Shifting error: Downstream")
        case .alreadyAtTail:
            return NSLocalizedString("Cannot shift production anymore", comment: "Shifting error: Already at tail")
        case .productionCostError:
            return NSLocalizedString("The production cost of origin card is higher than destination card", comment: "Shifting error: Production cost error")
        case .doNotOwnOriginCard:
            return NSLocalizedString("You do not own the origin card", comment: "Shifting error: Do not own origin card")
        case .doNotOwnDestinationCard:
            return NSLocalizedString("You do not own the destination card", comment: "Shifting error: Do not own destination card")
        case .unknownCardError:
            return NSLocalizedString("Illegal card action", comment: "Shifting error: Unknown card action")
        case .mustBePositive:
            return NSLocalizedString("Value must be positive", comment: "Shifting error: Must be positive")
        case .notEnoughUnits:
            return NSLocalizedString("Not enough units to shift", comment: "Shifting error: Not enough units")
        case .notEnoughMoney:
            return NSLocalizedString("Not enough money to perform shift", comment: "Shifting error: Not enough money")
        case .handIsEmpty:
            return NSLocalizedString("Hand is empty", comment: "Shifting error: Hand is empty")
        case .invalidPlayer:
            return NSLocalizedString("Invalid player", comment: "Shifting error: Invalid player")
        }
    }
}

class ShiftProduction {
    
    func shift(units: Int, from lhs: Card, to rhs: Card, player: Player?) throws -> Player? {
        guard (units.isPositive) else {
            throw ShiftErrorDelegate.mustBePositive
        }
        guard (lhs != rhs) else {
            throw ShiftErrorDelegate.sameCard
        }
        guard (lhs.productionUnits <= units) else {
            throw ShiftErrorDelegate.notEnoughUnits
        }
        guard (lhs.generation != rhs.generation) else {
            throw ShiftErrorDelegate.sameGeneration
        }
        guard (lhs.generation < rhs.generation) else {
            throw ShiftErrorDelegate.downStream
        }
        guard (lhs.productionCost < rhs.productionCost) else {
            throw ShiftErrorDelegate.productionCostError
        }
        guard (lhs.generation != Generation.fifth) else {
            throw ShiftErrorDelegate.alreadyAtTail
        }
        guard let player = player else {
            throw ShiftErrorDelegate.invalidPlayer
        }
        let budget = player.cash
        let cost = (rhs.productionCost - lhs.productionCost)
        let sum = (budget - cost)
        guard cost.isPositive else {
            throw ShiftErrorDelegate.notEnoughMoney
        }
        guard budget.isPositive else {
            throw ShiftErrorDelegate.notEnoughMoney
        }
        guard cost <= budget else {
            throw ShiftErrorDelegate.notEnoughMoney
        }
        guard sum.isPositive else {
            throw ShiftErrorDelegate.notEnoughMoney
        }
        guard let hand = player.hand else {
            throw ShiftErrorDelegate.handIsEmpty
        }
        guard let lhsFilteredCard = (hand.cards.filter {
            $0.name == lhs.name
        }.first) else {
            throw ShiftErrorDelegate.doNotOwnOriginCard
        }
        guard let rhsFilteredCard = (hand.cards.filter {
            $0.name == rhs.name
        }.first) else {
            throw ShiftErrorDelegate.doNotOwnDestinationCard
        }
        guard lhs.productionUnits <= units else {
            throw ShiftErrorDelegate.notEnoughUnits
        }
        

        // shift production
        rhsFilteredCard.productionUnits += units
        lhsFilteredCard.productionUnits -= units
        if lhsFilteredCard.productionUnits < 0 {
            lhsFilteredCard.productionUnits = 0
        }
        
        // reduce cash
        let w = Wallet(budget)
        guard let _ = try w.debit(budget) else {
            return nil
        }
        
        // if productionUnits on origin is 0, remove card from hand
        if (lhs.productionUnits == 0) {
            // pop card
            //player.hand.cards.remove(at:)
        }
        
        return player
    }
}
