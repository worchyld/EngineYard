//
//  SpendingInterface.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol SpendingDelegate : SpendUseCase, Validate_CanSpendUseCase {
    var balance: Int { get }
}

// MARK: Spend Use Case

protocol SpendUseCase {
    mutating func spend(amount: Int) throws -> Int
}

// MARK: `Spender`

// conforms to spending delegate
struct Spender : SpendingDelegate {
    internal var balance: Int

    init(_ balance: Int = 0) {
        self.balance = balance
    }

    private mutating func didSpend(_ amount: Int = 0) -> Int {
        self.balance -= amount
        return self.balance
    }
}

// MARK: `SpendingUseCase` Implementation

extension Spender : SpendUseCase {
    mutating func spend(amount: Int) throws -> Int {
        guard try canSpend(amount: amount) else {
            throw SpendingError.cannotSpend(amount)
        }

        return willSpend(amount: amount)
    }

    mutating func willSpend(amount: Int) -> Int {
        return self.didSpend(amount)
    }
}



// MARK: `ValidationSpendingUseCase` Implementation

extension Spender : Validate_CanSpendUseCase & Validate_PositiveUseCase {

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
        guard ((balance - amount) >= 0) else {
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
