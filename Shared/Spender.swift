//
//  SpendingInterface.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol SpendingUseCases : SpendUseCase, ValidateSpendUseCase {
    var value: Int { get }
}

struct Spender : SpendingUseCases {
    var value: Int

    init(value: Int = 0) {
        self.value = value
    }
}

// MARK: `SpendingUseCase` Implementation

extension Spender : SpendUseCase {
    mutating func spend(amount: Int) throws -> Int {
        guard try canSpend(amount: amount) else {
            throw SpendingError.cannotSpend(amount)
        }
        value -= amount
        return value
    }
}

// MARK: `ValidationSpendingUseCase` Implementation

extension Spender : ValidateSpendUseCase {

    func canSpend(amount: Int) throws -> Bool {
        guard try checkPositive(amount: amount) else {
            return false
        }
        guard try checkFunds(amount: amount) else {
            return false
        }
        return true
    }

    func checkFunds(amount: Int) throws -> Bool {
        guard ((value - amount) >= 0) else {
            throw SpendingError.notEnoughFunds(amount)
        }
        return true
    }

    func checkPositive(amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }

}
