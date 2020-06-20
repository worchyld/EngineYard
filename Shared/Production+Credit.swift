//
//  Production+Credit.swift
//  EngineYard
//
//  Created by Amarjit on 20/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Production : WillCreditDelegate {
    func credit(amount: Int) throws -> Int {
        try checkPositive(amount: amount)
        willCredit(units: amount)
        return self.units
    }

    private func willCredit(units: Int) {
        self.units += units
    }
}
