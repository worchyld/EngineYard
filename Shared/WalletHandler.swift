//
//  WalletHandler.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


protocol WalletUseCase : CreditUseCase, DebitUseCase  {
    var wallet: Wallet { get }
    var balance: Int { get }
}
protocol CreditUseCase {
    func credit(_ amount: Int) throws
}
protocol DebitUseCase {
    func debit(_ amount: Int) throws
}


class WalletHandler : WalletUseCase {
    internal var wallet: Wallet

    var balance: Int {
        return self.wallet.cash
    }

    init(_ balance: Int = 0) {
        precondition(balance >= 0, "Balance must be >= 0")

        self.wallet = Wallet(balance)
    }
}


extension WalletHandler : CreditUseCase {
    func credit(_ amount: Int) throws {
        if try canCredit(amount) {
            self.wallet.cash += amount
        }
    }
    private func canCredit(_ amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }
}

extension WalletHandler : DebitUseCase, Validate_Spending {
    func debit(_ amount: Int) throws {
        if try canSpend(amount: amount) {
            self.wallet.cash -= amount
        }
    }

    internal func canSpend(amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }

        let balance = self.balance

        guard ((balance - amount) >= 0) else {
            throw SpendingError.cannotSpend(amount)
        }

        return true
    }

}
