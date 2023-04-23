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
            try validate(units: units)
            self.card.productionUnits += units
        } catch let err {
            throw err
        }
    }
    
    func spend(units: Int) throws {
        do {
            try validate(units: units)
            try validateSubtract(units: self.card.productionUnits, amount: units)
                        
            self.card.spentUnits += units
            self.card.productionUnits -= units
        } catch let err {
            throw err
        }
    }
    
    func reset() {
        self.card.productionUnits = self.card.spentUnits
        //self.card.spentUnits = 0
    }
}

extension ProductionManager : Error {
    func validate(units: Int = 0) throws {
        guard units > 0 else {
            throw NumericError.mustBeGreaterThanZero
        }
    }
    func validateSubtract(units: Int = 0, amount: Int = 0) throws {
        do {
            try validate(units: units)
            try validate(units: amount)
        }
        catch let err {
            throw err
        }
    }
    internal func willSubtract(amount: Int = 0, from units: Int = 0) throws -> Int {
        let sum = units
        guard (sum - amount >= 0) else {
            throw NumericError.resultIsNegative
        }
        return (units - amount)
    }
}
