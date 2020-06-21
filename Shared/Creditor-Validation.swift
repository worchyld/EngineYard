//
//  Creditor-Validation.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: Credit Validation implementation

extension Creditor : Validate_PositiveUseCase {
    func checkPositive(amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }
}
