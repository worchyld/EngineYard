//
//  SpendingInterface.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol SpendingUseCases : SpendUseCase, ValidateSpendUseCase { }

struct SpendingInterface : SpendingUseCases {
    var value: Int

    init(value: Int = 0) {
        self.value = value
    }
}

// MARK: `SpendingUseCase` Implementation

extension SpendingInterface : SpendUseCase {
    mutating func spend(amount: Int) throws {
        if try canSpend(amount: amount) {
            value -= amount
        }
    }
}

// MARK: `ValidationSpendingUseCase` Implementation

extension SpendingInterface : ValidateSpendUseCase {
    func canSpend(amount: Int) throws -> Bool {
        try checkPositive(amount: amount)
        try checkFunds(amount: amount)
        
        return true
    }

    func checkPositive(amount: Int) throws {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
    }

    func checkFunds(amount: Int) throws {
        guard (value - amount).isPositive else {
            throw SpendingError.notEnoughFunds(amount)
        }
    }
}
