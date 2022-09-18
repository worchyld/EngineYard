//
//  ProductionManager.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2022.
//

import Foundation

protocol ProductionManagerUseCases {
    func add(_ units: Int) throws
    func subtract(_ units: Int) throws
    func spend(_ units: Int) throws
    func reset()
}

internal protocol ProductionManagerValidationDelegate {
    func canAdd(_ amount: Int) throws -> Bool
    func canSpend(_ amount: Int) throws -> Bool
}

class ProductionManager : ProductionManagerUseCases {
    private (set) var units: Int = 0
    private (set) var spent: Int = 0
    
    public var productionUnits: Int {
        return self.units
    }
    public var productionSpent: Int {
        return self.spent
    }
    
    init(units: Int = 0) {
        self.units = units
    }
    
    func add(_ units: Int) throws {
        guard try canAdd(units) else {
            return
        }
        self.units += units
    }
    
    func subtract(_ units: Int) throws {
        guard try canSpend(units) else {
            return
        }
        self.units -= units
    }
    
    func spend(_ units: Int) throws {
        guard try canSpend(units) else {
            return
        }
        self.spent += units
        self.units -= spent
    }
    
    func reset() {
        self.units += self.spent
    }
}

// MARK: Production validaation

extension ProductionManager : ProductionManagerValidationDelegate {
    internal func canAdd(_ amount: Int = 0) throws -> Bool {
        guard units.isPositive else {
            throw NumericErrorDelegate.cannotBeNegative
        }
        
        return true
    }
    
    internal func canSpend(_ amount: Int = 0) throws -> Bool {
        guard amount.isPositive else {
            throw NumericErrorDelegate.cannotBeNegative
        }

        let sum = units
        guard ((sum - amount) >= 0) else {
            throw NumericErrorDelegate.cannotCover(amount)
        }
        
        return true
    }
}
