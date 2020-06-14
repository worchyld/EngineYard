//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum WalletError : Error, Equatable {
    case mustBePositive
    case resultWillBeNegative
    case notEnoughFunds(_ funds: Int)
}

class Wallet {
    private(set) var balance: Int = 0

    init(_ balance: Int = 0) {
        self.balance = balance
    }
}

// MARK: Credit

extension Wallet {
    func credit(_ amount: Int = 0) throws -> Int? {
        do {
            let _ = try canCredit(amount)
            handleCredit(amount)
            return self.balance
        } catch {
            throw error
        }
    }

    internal func canCredit(_ amount: Int = 0) throws -> Bool {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        return true
    }

    private func handleCredit(_ amount: Int = 0) {
        self.balance += amount
    }
}


// MARK: Debit

extension Wallet {
    func debit(_ amount: Int = 0) -> Int {
        return self.balance
    }

    func canDebit(_ amount: Int = 0) throws -> Bool {
        guard amount > 0 else {
            throw WalletError.mustBePositive
        }
        guard (self.balance >= amount) else {
            throw WalletError.notEnoughFunds(self.balance)
        }
        guard ((self.balance - amount) >= 0) else {
            throw WalletError.resultWillBeNegative
        }

        return true
    }

    private func handleDebit(_ amount: Int = 0) {
        self.balance -= amount
    }
}

// MARK: canAfford

extension Wallet {
    func canAfford(_ amount: Int) throws -> Bool {
        do {
            let _ = try self.canDebit(amount)
            return true
        } catch {
            throw error
        }
    }
}

// MARK: Description

extension Wallet : CustomStringConvertible {
    var description: String {
        let cache = NumberFormatCache.currencyRateFormatter
        let number = NSNumber(integerLiteral: self.balance)
        let output = cache.string(from: number)
        return output ?? "$0"
    }
}
