//
//  SpendingUseCases.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: Spending Use Cases

protocol SpendingUseCase {
    func spend(amount: Int) throws
    func canSpend(amount: Int) throws -> Bool
}

protocol ValidateSpendingUseCase {
    func checkFunds(amount: Int) throws 
    func checkPositive(amount: Int) throws
}

// MARK: Spending errors

// Spending error
enum SpendingError : Error, Equatable {
    case mustBePositive(_ amount: Int)
    case notEnoughFunds(_ amount: Int)
}

// spending: localized error
extension SpendingError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .mustBePositive(amount):
            return "#{\(amount)} is not valid amount to spend"

        case let .notEnoughFunds(amount):
            return "Cannot spend #{\(amount)}"
        }
    }
}

