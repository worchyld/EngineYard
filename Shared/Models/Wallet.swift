//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 02/03/2022.
//

import Foundation

// Simple cash handling with error throwing

internal protocol WalletDelegate {
    func didCredit(_amount: Int) -> Bool
    func didDebit(_amount: Int) -> Bool
}

public enum WalletErrorDelegate: Error, Equatable {
    case mustBePositive
    case notEnoughBalance
    //case need(balance: Int)  Un-used for now
}

// The use cases of the wallet
protocol WalletUseCases {
    func credit(_ amount: Int) throws -> Int?
    func debit(_ amount: Int) throws -> Int?
}

class Wallet : WalletUseCases {
    private (set) var balance : Int = 0

    // credit
    func credit(_ amount: Int = 0) throws -> Int? {
        guard try canCredit(amount) else {
            return nil
        }
        executeCredit(amount)
        return self.balance
    }
    
    // debit
    func debit(_ amount: Int = 0) throws -> Int? {
        guard try canDebit(amount) else {
            return nil
        }
        executeDebit(amount)
        return self.balance
    }
}

extension Wallet: CustomStringConvertible {
    var description: String {
        return "$\(self.balance)"
    }
}

extension Wallet {
    
    // amount must be positive, cannot credit negative numbers
    func canCredit(_ amount: Int = 0) throws -> Bool {
        guard amount.isPositive else {
            throw WalletErrorDelegate.mustBePositive
        }
        return true
    }

    // amount must be positive, cannot debit negative numbers
    // the wallet must be greater than or equal to the subtraction
    // the amount remaining in the wallet must not be negative
    func canDebit(_ amount: Int = 0) throws -> Bool {
        guard amount.isPositive else {
            throw WalletErrorDelegate.mustBePositive
        }
        guard balance >= amount else {
            throw WalletErrorDelegate.notEnoughBalance
        }
        let sum = balance
        guard ((sum - amount) >= 0) else {
            throw WalletErrorDelegate.notEnoughBalance
        }
        
        return true
    }
    
    
    private func executeCredit(_ funds: Int = 0) {
        self.balance += funds
    }
    private func executeDebit(_ funds: Int = 0) {
        self.balance -= funds
    }
}
