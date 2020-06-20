//
//  Production+Spend.swift
//  EngineYard
//
//  Created by Amarjit on 20/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Production : WillSpendDelegate {
    func spend(amount: Int) throws -> Int {
        try checkPositive(amount: amount)
        try checkHasFunds(amount: amount)
        willSpend(units: amount)
        return self.units
    }

    internal func willSpend(units: Int) {
        self.spent += units
        self.units -= units
    }
}

extension Production : ResetProductionDelegate {
    func reset(production: inout Production) {
        production.units = self.spent
        production.spent = 0
    }
}
