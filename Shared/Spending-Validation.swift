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

protocol SpendUseCase {
    mutating func spend(amount: Int) throws -> Int
}

protocol Validate_Spending {
    func canSpend(amount: Int) throws -> Bool
}

protocol Validate_PositiveUseCase {
    func checkPositive(amount: Int) throws -> Bool
}
