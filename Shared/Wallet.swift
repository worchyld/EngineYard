//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol WalletProtocol {
    var balance: Int { get }
    func credit(amount: Int) -> Bool
    func debit(amount: Int) -> Bool
    func canCredit(amount: Int) -> Bool
    func canDebit(amount: Int) -> Bool
}

// #TODO - Needs work

// Credits and debits coins to a player's wallet

class Wallet: WalletProtocol {
    var balance: Int = 0

    func credit(amount: Int) -> Bool {
        return false
    }

    func debit(amount: Int) -> Bool {
        return false
    }

    func canCredit(amount: Int) -> Bool {
        return false
    }

    func canDebit(amount: Int) -> Bool {
        return false
    }
}
