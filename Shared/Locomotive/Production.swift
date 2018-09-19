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
    case cannotSelectSameCard
    case cannotSelectCardFromSameParent
    case cannotUpgradeDownstream
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
            print ("card has no deck parent")
            return 0
        }
        return hasParent.productionCost
    }

    func setParent(card: Card) {
        self.parent = card
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

// Shift methods
extension Production {
    public static func costToShift(amount: Int, from: Card, to: Card) throws -> Int {
        do {
            try canShift(amount: amount, from: from, to: to)
        } catch let error as ProductionError {
            throw error
        }

        return ((to.production.cost - from.production.cost) * amount)
    }
    
    private static func canShift(amount: Int, from: Card, to: Card) throws {
        guard amount > 0 else {
            throw ProductionError.mustBePositive
        }
        guard from != to else {
            throw ProductionError.cannotSelectSameCard
        }
        guard from.parent != to.parent else {
            throw ProductionError.cannotSelectCardFromSameParent
        }
        // Shifting production can only go upstream
        guard ((from.parent?.cost)! < (to.parent?.cost)!) else {
            throw ProductionError.cannotUpgradeDownstream
        }
    }
}
