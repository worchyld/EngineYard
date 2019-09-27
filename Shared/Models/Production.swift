//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 27/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum ProductionError : Error {
    case mustBePositive
    case notEnoughUnits
    case cannotUpgradeDownstream
}

final class Production {
    private var spentUnits: Int
    var units: Int

    init(parent: Deck, units: Int = 0) {
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
}

extension Production {
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

// Shifting production from one card to another
extension Production {
    private func shift(from: Card, to: Card, units: Int) {
        guard canShift(from: from, to: to, units: units) else {
            return
        }
        // #TODO
    }

    private func canShift(from: Card, to: Card, units: Int) -> Bool {
        return false
    }
}
