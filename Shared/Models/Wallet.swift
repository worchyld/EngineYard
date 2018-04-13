//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 22/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// A player's wallet (cash using Ints only)
class Wallet : CustomStringConvertible
{
    public private (set) var balance: Int = 0

    init(balance: Int = 0) {
        self.balance = balance
    }

    func credit(amount: Int) {
        if (self.canCredit(amount: amount)) {
            self.balance += amount
        }
    }

    func debit(amount: Int) {
        if (self.canDebit(amount: amount)) {
            self.balance -= amount
        }
    }
}

extension Wallet {

    func canCredit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        return true
    }

    func canDebit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        guard self.balance >= amount else {
            return false
        }
        guard (self.balance - amount >= 0) else {
            return false
        }
        return true
    }

}

extension Wallet {

    var description: String {
        return ("self.balance: \(self.balance)")
    }

}
