//
//  ProductionManager.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation

class ProductionManager {
    private var card: Card
    
    init(card: Card) {
        self.card = card
    }
    
    func add(units: Int) throws {
        do {
            try canAdd(units: units)
            self.card.add(units: units)
        } catch let err {
            throw err
        }
    }
    
    func spend(units: Int) throws {
        do {
            try canSpend(units: units)
            self.card.spend(units: units)
        } catch let err {
            throw err
        }
    }
    
    func reset() {
        self.card.resetUnits()
    }
    
    func transfer() {
        // #MARK: TBD
    }
    
    internal func canAdd(units: Int) throws {
        do {
            try validateNumberIsPositive(units)
        } catch let err {
            throw err
        }
    }
    
    internal func canSpend(units: Int) throws {
        do {
            try validateNumberIsPositive(units)
            try validateSubtract(units: self.card.productionUnits, amount: units)
        } catch let err {
            throw err
        }
    }
}

extension ProductionManager : Error {
    func validateNumberIsPositive(_ number: Int = 0) throws {
        guard number > 0 else {
            throw NumericError.mustBeGreaterThanZero
        }
    }
    func validateSubtract(units: Int = 0, amount: Int = 0) throws {
        do {
            try validateNumberIsPositive(units)
            try validateNumberIsPositive(amount)
            
            let sum = units
            guard (sum - amount >= 0) else {
                throw NumericError.resultIsNegative
            }
        }
        catch let err {
            throw err
        }
    }
}
