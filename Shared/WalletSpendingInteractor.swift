//
//  WalletSpendingInteractor.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol WalletSpendingInteractorUseCase {
    var wallet : Wallet { get }
    var delegate : SpendingDelegate? { get }
}

struct WalletSpendingInteractor: WalletSpendingInteractorUseCase {
    var wallet: Wallet
    var delegate: SpendingDelegate?

    init(wallet: Wallet) {
        self.wallet = wallet
        self.delegate = Spender(value: self.wallet.cash)
    }

    mutating func debit(amount: Int) throws {
        guard let cash = try delegate?.spend(amount: amount) else {
            return
        }
        updateCash(amount: cash)
    }

    private func updateCash(amount: Int) {
        self.wallet.cash = amount
    }
}
