//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum WalletError : Error {
    case mustBePositive
    case notEnoughFunds
}

protocol WalletDelegate {
    var balance : Int { get }
    func credit(amount: Int) throws
    func debit(amount: Int) throws
}

final class Wallet : CustomStringConvertible, WalletDelegate {
    public private(set) var balance: Int = 0

    init(amount: Int = 0) {
        self.balance = amount
    }

    func credit(amount: Int) throws {
        try canCredit(amount: amount)
        handleCredit(amount: amount)
    }

    func debit(amount: Int) throws {
        try canDebit(amount: amount)
        handleDebit(amount: amount)
    }
}

extension Wallet {
    // MARK: (Private)

    private func canCredit(amount: Int) throws {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
    }

    private func canDebit(amount: Int) throws {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        guard balance >= amount else {
            throw WalletError.notEnoughFunds
        }
        guard (self.balance - amount >= 0) else {
            throw WalletError.notEnoughFunds
        }
    }

    private func handleCredit(amount: Int) {
        self.balance += amount
    }

    private func handleDebit(amount: Int) {
        self.balance -= amount
    }
}

extension Wallet {
    var description: String {
        return ("Balance: $\(self.balance)")
    }
}
