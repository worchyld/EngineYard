//
//  ShiftProduction.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum ShiftProductionErrorDelegate : Error {
    case mustBePositive
    case sameCard
    case mustBeHigherGeneration
    case noLocomotive
    case notEnoughProductionUnits(units: Int)
    case cardIsNotActive // .new || .rusting
    case cardHasRusted
}

extension ShiftProductionErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mustBePositive:
            return NSLocalizedString("Value must be positive", comment: "Shifting error: Must be positive")
            
        case .sameCard:
            return NSLocalizedString("Cannot shift production to the same card", comment: "Shifting error: Same card")
            
        case .cardHasRusted:
            return NSLocalizedString("Cannot shift production, card is rusted", comment: "Shifting error: Rusted card")
            
        case .cardIsNotActive:
            return NSLocalizedString("Cannot shift production, card is not active", comment: "Shifting error: Card is not active")
            
            
        case .noLocomotive:
            return NSLocalizedString("No locomotive found", comment: "Shifting error: No locomotive found")
            
        case .mustBeHigherGeneration:
            return NSLocalizedString("Can only shift production to a higher generation", comment: "Shifting error: Must be higher generation")
            
        case .notEnoughProductionUnits(let units):
            return NSLocalizedString("Not enough production units: \(units)", comment: "Shifting error: Not enough production units")
        }
    }
}

class ShiftProduction {
    public func costToShift(units: Int, from: Card, to: Card) -> Result<Int, ShiftProductionErrorDelegate> {
        do {
            try valdiateShift(units: units, from: from, to: to)
            
            guard let destination = to.loco else {
                return .failure(.noLocomotive)
            }
            
            let cost = (destination.productionCost * units)
            return .success(cost)
        } catch let err {
            return .failure(err as! ShiftProductionErrorDelegate)
        }
    }
    
    public func shift(units: Int, from: Card, to: Card) -> Result<Bool, ShiftProductionErrorDelegate> {
        do {
            try valdiateShift(units: units, from: from, to: to)
            
            let fromProduction = from.production.execute(.reduceProductionUnits(units))
            let toProduction = to.production.execute(.addProductionUnits(units))
            
            from.changeProduction(fromProduction)
            to.changeProduction(toProduction)
            
            // if from.production is zero, notify hand manager to remove card
            
            return .success(true)
        } catch let err {
            return .failure(err as! ShiftProductionErrorDelegate)
        }
    }
    
    private func valdiateShift(units: Int, from: Card, to: Card) throws {
        guard (units.isPositive) else {
            throw ShiftProductionErrorDelegate.mustBePositive
        }
        if (from == to) {
            throw ShiftProductionErrorDelegate.sameCard
        }
        guard let fromLoco = from.loco else {
            throw ShiftProductionErrorDelegate.noLocomotive
        }
        guard (fromLoco.isAvailable) else {
            throw ShiftProductionErrorDelegate.cardIsNotActive
        }
        if (fromLoco.rust == .rusted) {
            throw ShiftProductionErrorDelegate.cardHasRusted
        }
        guard let toLoco = to.loco else {
            throw ShiftProductionErrorDelegate.noLocomotive
        }
        guard (toLoco.isAvailable) else {
            throw ShiftProductionErrorDelegate.cardIsNotActive
        }
        if (toLoco.rust == .rusted) {
            throw ShiftProductionErrorDelegate.cardHasRusted
        }
        guard (fromLoco.generation > toLoco.generation) else {
            throw ShiftProductionErrorDelegate.mustBeHigherGeneration
        }
        guard (from.production.units <= units) else {
            throw ShiftProductionErrorDelegate.notEnoughProductionUnits(units: units)
        }
        let sum = (from.production.units - units)
        guard (sum >= 0) else {
            throw ShiftProductionErrorDelegate.notEnoughProductionUnits(units: units)
        }
    }
}
