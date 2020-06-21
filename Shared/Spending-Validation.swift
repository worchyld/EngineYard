//
//  Spending-Validation.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: Spending Validation protocols
// Can be used in other areas

protocol Validate_CanSpendUseCase {
    func canSpend(amount: Int) throws -> Bool
    func checkFunds(amount: Int) throws -> Bool
}

protocol Validate_PositiveUseCase {
    func checkPositive(amount: Int) throws -> Bool
}


