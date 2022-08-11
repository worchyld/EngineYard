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

// The use cases of the wallet
protocol WalletUseCases {
    var getBalance: Int { get }
    func credit(_ amount: Int) throws -> Int?
    func debit(_ amount: Int) throws -> Int?
}

protocol WalletValidationDelegate {
    func canCredit(_ amount: Int) throws -> Bool
    func canDebit(_ amount: Int) throws -> Bool
}

class Wallet : WalletUseCases {
    private (set) var balance : Int = 0
    
    var getBalance: Int {
        return self.balance
    }
    
    init(_ balance: Int = 0) {
        self.balance = balance
    }

    // credit
    func credit(_ amount: Int = 0) throws -> Int? {
        guard try canCredit(amount) else {
            return nil
        }
        self.balance += amount
        return self.balance
    }
    
    // debit
    func debit(_ amount: Int = 0) throws -> Int? {
        guard try canDebit(amount) else {
            return nil
        }
        self.balance -= amount
        return self.balance
    }
}

extension Wallet: CustomStringConvertible {
    var description: String {
        return "$\(self.balance)"
    }
}


// MARK: Validation

extension Wallet : WalletValidationDelegate {
    
    // amount must be positive, cannot credit negative numbers
    func canCredit(_ amount: Int = 0) throws -> Bool {
        guard amount.isPositive else {
            throw NumericErrorDelegate.cannotBeNegative
        }
        return true
    }

    // amount must be positive, cannot debit negative numbers
    // the wallet must be greater than or equal to the subtraction
    // the amount remaining in the wallet must not be negative
    func canDebit(_ amount: Int = 0) throws -> Bool {
        guard amount.isPositive else {
            throw NumericErrorDelegate.cannotBeNegative
        }
        guard balance >= amount else {
            throw NumericErrorDelegate.notEnoughFunds
        }
        let sum = balance
        guard ((sum - amount) >= 0) else {
            throw NumericErrorDelegate.cannotCover(amount)
        }
        
        return true
    }
}
