//
//  WalletCreditInteractor.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol CreditDelegate : CreditUseCase, ValidateCreditUseCase {
    var value: Int { get }
}

protocol WalletCreditInteractorUseCase {
    var wallet : Wallet { get }
    var delegate : CreditDelegate? { get }
}

protocol CreditUseCase {
    mutating func credit(amount: Int) throws -> Int
}

protocol ValidateCreditUseCase {
    func checkPositive(amount: Int) throws -> Bool
}

struct WalletCreditInteractor : WalletCreditInteractorUseCase {
    var wallet: Wallet
    var delegate: CreditDelegate?

    init(wallet: Wallet) {
        self.wallet = wallet
        self.delegate = Creditor(value: self.wallet.cash)
    }

    mutating func credit(amount: Int) throws {
        guard let cash = try delegate?.credit(amount: amount) else {
            return
        }

        updateCash(amount: cash)
    }

    private func updateCash(amount: Int) {
        self.wallet.cash = amount
    }
}

struct Creditor : CreditDelegate {
    var value: Int

    mutating func credit(amount: Int) throws -> Int {
        guard try checkPositive(amount: amount) else {
            throw SpendingError.invalidAmount
        }
        value += amount
        return value
    }

    func checkPositive(amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }
}
