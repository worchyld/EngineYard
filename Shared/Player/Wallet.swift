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

fileprivate protocol WalletDelegate {
    var balance : Int { get }
    func credit(amount: Int) throws
    func debit(amount: Int) throws
}

class Wallet : NSCopying, CustomStringConvertible, WalletDelegate {
    public private(set) var balance: Int = 0

    func credit(amount: Int = 0) throws {
        try canCredit(amount: amount)
        self.balance += amount
    }

    func debit(amount: Int = 0) throws {
        try canDebit(amount: amount)
        self.balance -= amount
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Wallet()
        copy.balance = self.balance
        return copy
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

