//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ResetProductionDelegate {
    func reset(production: inout Production)
    static func builder(units: Int) -> Production
}

struct Production : Equatable {
    let id: UUID
    private (set) var units: Int
    private var spent: Int = 0

    init(units: Int = 0) {
        self.id = UUID()
        self.units = units
    }
}

extension Production : WillCreditDelegate {
    mutating func credit(amount: Int) throws -> Int {
        try checkPositive(amount: amount)
        willCredit(units: amount)
        return self.units
    }

    internal mutating func willCredit(units: Int) {
        self.units += units
    }
}

extension Production : WillSpendDelegate {
    mutating func spend(amount: Int) throws -> Int {
        try checkPositive(amount: amount)
        try checkHasFunds(amount: amount)
        willSpend(units: amount)
        return self.units
    }

    internal mutating func willSpend(units: Int) {
        self.spent += units
        self.units -= units
    }
}

extension Production : ResetProductionDelegate {
    func reset(production: inout Production) {
        production = Production.builder(units: self.spent)
    }

    public static func builder(units: Int = 0) -> Production {
        return Production(units: units)
    }
}

extension Production : ValidateFundsDelegate & ValidatePositiveDelegate {
    func checkHasFunds(amount: Int) throws {
        guard (units - amount).isPositive else {
            throw SpendingError.notEnoughFunds(amount)
        }
    }

    func checkPositive(amount: Int) throws {
        guard (amount).isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
    }
}
