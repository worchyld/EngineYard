//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum ProductionError : Error {
    case mustBePositive
    case notEnoughUnits
    case cannotSelectSameCard
    case cannotSelectCardFromSameParent
    case cannotUpgradeDownstream
}

class Card {
    var units: Int
    private var spentUnits: Int

    init(units: Int = 0) {
        self.units = units
        self.spentUnits = 0
    }

    func spend(units: Int) {
        do {
            try canSpend(amount: units)
        } catch let error {
            print(error)
        }
    }

    private func didSpend(units: Int) {
        self.spentUnits += units
        self.units -= units
    }

    private func reset() {
        self.units = self.spentUnits
        self.spentUnits = 0
    }

    func shift(units: Int, to card: Card) {
        guard canShift(units: units, to: card) else {
            return
        }
    }

    private func canShift(units: Int, to: Card) -> Bool {
        return false
    }
}


extension Card {
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
