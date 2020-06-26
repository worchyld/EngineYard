//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ProductionInputDelegate {
    var productionCost: Int { get }
    var production: Int { get set }
    var spentProduction: Int { get set }
}

protocol ProductionUseCase {
    func reset()
    func shift()
}

class Production: ProductionUseCase {
    private var delegate: ProductionInputDelegate

    var cost: Int {
        return delegate.productionCost
    }

    init(with delegate: ProductionInputDelegate) {
        self.delegate = delegate
    }

    func increase(by amount: Int) throws -> Int {
        return 0
    }

    func spend(amount: Int) throws -> Int {
        return 0
    }

    func reset() {
    }

    func shift() {
    }
}

extension Production {
    func canAfford(units: Int = 0, cash: Int = 0) throws -> Bool {
        guard units.isPositive else {
            throw SpendingError.mustBePositive(units)
        }
        guard cash.isPositive else {
            throw SpendingError.mustBePositive(cash)
        }
        let total = (self.cost * units)
        guard cash >= total else {
            throw SpendingError.cannotSpend(total)
        }
        return true
    }
}
