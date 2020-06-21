//
//  Spending-Errors.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: Spending errors

// spending errors
enum SpendingError : Error, Equatable {
    case mustBePositive(_ amount: Int)
    case notEnoughFunds(_ amount: Int)
    case cannotSpend(_ amount: Int)
    case invalidAmount
}

// spending: localized error
extension SpendingError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .mustBePositive(amount):
            return "#{\(amount)} is not valid amount to spend"

        case let .notEnoughFunds(amount):
            return "Cannot spend #{\(amount)}"

        case let .cannotSpend(amount):
            return "Cannot spend #{\(amount)}"

        case .invalidAmount:
            return "Invalid amount"
        }
    }
}

