//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum ProductionError : Error {
    case mustBePositive
    case notEnoughUnits
}

final class Production {
    public private (set) weak var parent: Card?
    public private (set) var units: Int = 0 {
        didSet {
            if (units < 0) {
                units = 0
            }
        }
    }
    public private (set) var spentUnits: Int = 0 {
        didSet {
            if (spentUnits < 0) {
                spentUnits = 0
            }
        }
    }
    var cost : Int {
        guard let hasParent = self.parent?.parent else {
            return 0
        }
        return hasParent.productionCost
    }

    func add(_ amount: Int = 0) {
        guard amount > 0 else {
            return
        }
        self.units += amount
    }

    func spend(_ amount: Int = 0) throws {
        try canSpend(amount: amount)
        self.spentUnits += amount
        self.units -= amount
    }

    func reset() {
        self.units += self.spentUnits
        self.spentUnits = 0
    }

    private func canSpend(amount: Int) throws {
        guard amount > 0 else {
            throw ProductionError.mustBePositive
        }
        guard self.units >= amount else {
            throw ProductionError.notEnoughUnits
        }
        guard (self.units - amount >= 0) else {
            throw ProductionError.notEnoughUnits
        }
    }
}


