//
//  Wallet+Spend.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Wallet implementing SpendingDelegates
extension Wallet : ValidateFundsDelegate & ValidatePositiveDelegate {
    func checkHasFunds(amount: Int) throws {
        guard (cash - amount).isPositive else {
            throw SpendingError.notEnoughFunds(amount)
        }
    }
    func checkPositive(amount: Int) throws {
        guard (amount).isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
    }

}


extension Wallet : WillSpendDelegate {

    mutating func spend(amount: Int) throws -> Int {
        try checkPositive(amount: amount)
        try checkHasFunds(amount: amount)

        self.cash -= amount

        return self.cash
    }
}

extension Wallet : WillCreditDelegate {

    mutating func credit(amount: Int) throws -> Int {
        try checkPositive(amount: amount)

        self.cash += amount

        return self.cash
    }
}
