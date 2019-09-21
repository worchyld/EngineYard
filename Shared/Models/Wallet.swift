//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

public enum WalletError: Error {
    case mustBePositive
    case notEnoughFunds
}

fileprivate protocol WalletDelegate {
    func handleDebit(balance: Int, amount: Int) -> Int
    func handleCredit(balance: Int, amount: Int) -> Int
}

// Simple cash:Int credit/debit handling
struct Wallet {
    func debit(balance: Int, amount: Int) throws -> Int? {
        guard let result = try canDebit(balance: balance, amount: amount) else {
            return nil
        }
        return result
    }

    func credit(balance: Int, amount: Int) throws -> Int? {
        guard let result = try canCredit(balance: balance, amount: amount) else {
            return nil
        }
        return result
    }
}

extension Wallet {
    private func canDebit(balance: Int, amount: Int) throws -> Int? {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        guard balance > 0 else {
            throw WalletError.notEnoughFunds
        }
        let sum = balance
        guard ((sum - amount) > 0) else {
            throw WalletError.notEnoughFunds
        }
        return handleDebit(balance: balance, amount: amount)
    }

    private func canCredit(balance: Int, amount: Int) throws -> Int? {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        return handleCredit(balance: balance, amount: amount)
    }
}

extension Wallet: WalletDelegate {
    fileprivate func handleDebit(balance: Int, amount: Int) -> Int {
        return (balance - amount)
    }
    fileprivate func handleCredit(balance: Int, amount: Int) -> Int {
        return (balance + amount)
    }
}
