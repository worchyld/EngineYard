//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 02/03/2022.
//

import Foundation

// Simple cash handling

internal protocol WalletDelegate {
    func didCredit(_amount: Int) -> Bool
    func didDebit(_amount: Int) -> Bool
}

class Wallet {
    private (set) var balance : Int = 0
}

extension Wallet {
    func credit(_ amount: Int = 0) -> Bool {
        guard (!amount.isNegative) else {
            return false
        }
        self.willCredit(amount)
        return didCredit(_amount: amount)
    }
    func debit(_ amount: Int = 0) -> Bool {
        guard (amount.isPositive) else {
            return false
        }
        self.willDebit(amount)
        return didDebit(_amount: amount)
    }
    
    private func willCredit(_ funds: Int = 0) {
        self.balance += funds
    }
    private func willDebit(_ funds: Int = 0) {
        self.balance -= funds
    }
}

extension Wallet : WalletDelegate {
    internal func didCredit(_amount: Int) -> Bool {
        return true
    }
    
    internal func didDebit(_amount: Int) -> Bool {
        return true
    }
}
