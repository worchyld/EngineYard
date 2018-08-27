//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

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

    // In the rules, when a player buys a card, it gets 1 production unit
    func setup() {
        self.add(amount: 1)
    }

    func add(amount: Int = 0) {
        guard amount > 0 else {
            return
        }
        self.units += amount
    }

    func spend(amount: Int = 0) {
        if (canSpend(spending: amount)) {
            self.spentUnits += amount
            self.units -= amount
        }
    }

    func reset() {
        self.units += self.spentUnits
        self.spentUnits = 0
    }

    func canSpend(spending: Int) -> Bool {
        guard spending > 0 else {
            return false
        }
        return ( (self.units - spending) >= 0 )
    }
}
