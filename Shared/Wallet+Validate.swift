//
//  Wallet+Validate.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Wallet : ValidateFundsDelegate & ValidatePositiveDelegate {
    func checkHasFunds(amount: Int) throws {
        guard (cash - amount).isPositive else {
            throw SpendingError.notEnoughFunds(amount)
        }
    }

    func checkPositive(amount: Int) throws {
        guard (amount).isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
    }
}
