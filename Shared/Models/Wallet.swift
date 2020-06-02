//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

public enum WalletError: Error, Equatable {
    case mustBePositive
    case notEnoughFunds
    case insufficientFunds(coinsNeeded: Int)
}

fileprivate protocol WalletDelegate {
    func credit(amount: Int) throws -> Int?
    func debit(amount: Int) throws -> Int?
}

fileprivate protocol WalletHandlerDelegate {
    func handleDebit(amount: Int) -> Int
    func handleCredit(amount: Int) -> Int
}

class Wallet : WalletDelegate {
    public private (set) var balance: Int = 0

    init(balance: Int = 0) {
        self.balance = balance
    }

    func debit(amount: Int) throws -> Int? {
        guard let result = try canDebit(amount: amount) else {
            return nil
        }
        return result
    }

    func credit(amount: Int) throws -> Int? {
        guard let result = try canCredit(amount: amount) else {
            return nil
        }
        return result
    }
}

extension Wallet: CustomStringConvertible {
    var description: String {
        return "$\(self.balance)"
    }
}

extension Wallet {
    private func canDebit(amount: Int) throws -> Int? {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        guard balance >= amount else {
            throw WalletError.notEnoughFunds
        }
        let sum = balance
        guard ((sum - amount) >= 0) else {
            throw WalletError.notEnoughFunds
        }
        return handleDebit(amount: amount)
    }

    private func canCredit(amount: Int) throws -> Int? {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        return handleCredit(amount: amount)
    }
}

extension Wallet: WalletHandlerDelegate {
    fileprivate func handleDebit(amount: Int) -> Int {
        self.balance -= amount
        return (self.balance)
    }
    fileprivate func handleCredit(amount: Int) -> Int {
        self.balance += amount
        return self.balance
    }
}
