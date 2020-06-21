//
//  Credor.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol CreditDelegate : CreditUseCase, Validate_PositiveUseCase {
    var balance: Int { get }
}

protocol CreditUseCase {
    mutating func credit(amount: Int) throws -> Int
}

// MARK: Creditor

struct Creditor : CreditDelegate {
    internal var balance: Int

    init(_ balance: Int = 0) {
        self.balance = balance
    }

    private mutating func didCredit(amount: Int) -> Int {
        self.balance += amount
        return self.balance
    }
}

// MARK: Credit implementation

extension Creditor : CreditUseCase {
    mutating func credit(amount: Int) throws -> Int {
        guard try checkPositive(amount: amount) else {
            throw SpendingError.invalidAmount
        }

        return willCredit(amount: amount)
    }

    mutating func willCredit(amount: Int) -> Int {
        return self.didCredit(amount: amount)
    }
}
