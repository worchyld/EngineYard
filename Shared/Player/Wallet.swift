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

fileprivate enum Transaction {
    case credit(amount: Int)
    case debit(amount: Int)
}

fileprivate protocol WalletDelegate {
    var balance : Int { get }
    func credit(amount: Int) throws
    func debit(amount: Int) throws
}

final class Wallet : CustomStringConvertible, WalletDelegate {
    public private(set) var balance: Int = 0

    init(amount: Int = 0) {
        do {
            try credit(amount: amount)
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }

    func credit(amount: Int = 0) throws {
        try canCredit(amount: amount)
        handleTransaction(Transaction.credit(amount: amount))
    }

    func debit(amount: Int = 0) throws {
        try canDebit(amount: amount)
        handleTransaction(Transaction.debit(amount: amount))
    }
}

extension Wallet {
    private func handleTransaction(_ t: Transaction) {
        switch t {
        case let .credit(amount):
            self.balance += amount
            break
        case let .debit(amount):
            self.balance -= amount
            break
        }
    }
}

extension Wallet {
    private func canCredit(amount: Int) throws {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
    }

    private func canDebit(amount: Int) throws {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }

        guard self.balance >= amount else {
            throw WalletError.notEnoughFunds
        }
        guard (self.balance - amount >= 0) else {
            throw WalletError.notEnoughFunds
        }
    }
}

extension Wallet {
    var description: String {
        return ("Balance: $\(self.balance)")
    }
}

