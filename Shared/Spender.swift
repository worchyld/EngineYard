//
//  Spender.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum SpendingError : Error, Equatable {
    case mustBePositive(_ amount: Int)
    case notEnoughFunds(_ amount: Int)
}

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

protocol ValidateSpendingDelegate {
    func checkHasFunds(amount: Int) throws
    func checkPositive(amount: Int) throws
}

protocol WillSpendDelegate {
    mutating func spend(amount: Int) throws -> Int
}
