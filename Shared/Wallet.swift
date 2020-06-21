//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/** Wallet is an interface/interactor for a player's cash **/

protocol WalletUseCases: SpendingUseCase, ValidateSpendingUseCase {
    var cash: Int { get }
}

class Wallet : WalletUseCases {
    internal var cash: Int

    init(_ cash: Int = 0) {
        self.cash = cash
    }
}

// MARK: `SpendingUseCase` Implementation

extension Wallet : SpendingUseCase {
    func spend(amount: Int) throws {
        if try canSpend(amount: amount) {
            self.cash -= amount
        }
    }

    func canSpend(amount: Int) throws -> Bool {
        try checkPositive(amount: amount)
        try checkFunds(amount: amount)
        return true
    }
}

// MARK: `ValidationSpendingUseCase` Implementation

extension Wallet : ValidateSpendingUseCase {
    func checkPositive(amount: Int) throws {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
    }

    func checkFunds(amount: Int) throws {
        guard (cash - amount).isPositive else {
            throw SpendingError.notEnoughFunds(amount)
        }
    }
}
