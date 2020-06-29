//
//  Spending.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: Spending errors

protocol ValidateIncrease {
    func canIncrease(by amount: Int) throws -> Bool
}

protocol ValidateSpending {
    func canSpend(amount: Int) throws -> Bool
}

protocol SpendingUseCase {
    func spend(amount: Int) throws -> Int
}


class Spender : ValidateSpending, SpendingUseCase {
    private (set) var value : Int

    init(_ value: Int = 0) {
        precondition(value >= 0, "Must initalise Spender with a number >= 0")
        self.value = value
    }

    func spend(amount: Int) throws -> Int {
        if try canSpend(amount: amount) {
            self.value -= amount
        }
        return self.value
    }

    func canSpend(amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingMoneyError(reason: .mustBePositive)
        }
        guard value.isPositive else {
            throw SpendingMoneyError(reason: .mustBePositive)
        }
        guard ((value - amount) >= 0) else {
            throw SpendingMoneyError(reason: .notEnoughFunds(amount: amount))
        }
        return true
    }
}

protocol IncreaserUseCase {
    func increase(by amount: Int) throws -> Int
}

class Increaser : ValidateIncrease, IncreaserUseCase {
    private (set) var value: Int

    init(_ value: Int = 0) {
        precondition(value >= 0, "Must initialise Increaser with a number >=0")
        self.value = value
    }

    func increase(by amount: Int) throws -> Int {
        if try canIncrease(by: amount) {
            self.value += amount
        }
        return self.value
    }

    func canIncrease(by amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingMoneyError(reason: .mustBePositive)
        }
        return true
    }
}
