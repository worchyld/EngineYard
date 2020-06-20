//
//  Production+Validate.swift
//  EngineYard
//
//  Created by Amarjit on 20/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

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
