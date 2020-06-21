//
//  WalletInteractor.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class WalletInteractor {
    private var wallet: Wallet
    private var creditDelegate: CreditDelegate?
    private var debitDelegate: SpendingDelegate?

    init(wallet: Wallet) {
        self.wallet = wallet
    }

    func credit(amount: Int) throws {
        creditDelegate = Creditor(value: self.wallet.cash)

        guard let amount = try creditDelegate?.credit(amount: amount) else {
            return
        }

        updateWallet(amount: amount)
    }

    func debit(amount: Int) throws {
        self.debitDelegate = Spender(value: self.wallet.cash)

        guard let amount = try debitDelegate?.spend(amount: amount) else {
            return
        }

        updateWallet(amount: amount)
    }

    private func updateWallet(amount: Int) {
        self.wallet.cash = amount
    }
}
