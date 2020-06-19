//
//  Wallet+Credit.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Wallet : WillCreditDelegate {

    mutating func credit(amount: Int) throws -> Int {
        try checkPositive(amount: amount)

        self.cash += amount

        return self.cash
    }
}
