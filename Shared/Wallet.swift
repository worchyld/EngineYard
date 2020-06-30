//
//  WalletHandler.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol WalletHolderDelegate: class {
    var cash: Int { get set }
}

protocol BankDebitUseCase {
    func debit(account: WalletHolderDelegate, amount: Int) throws
}
protocol BankCreditUseCase {
    func credit(account: WalletHolderDelegate, amount: Int) throws
}
protocol Bank : BankCreditUseCase, BankDebitUseCase {}


struct Wallet : Bank {

    func credit(account: WalletHolderDelegate, amount: Int = 0) throws {

        do {
            if try canAdd(amount: amount) {
                willAdd(funds: amount, to: account)
            }
        }
        catch {
            throw error
        }
    }

    func canCredit(account: WalletHolderDelegate, amount: Int = 0) throws -> Bool {
        return try canAdd(amount: amount)
    }


    func debit(account: WalletHolderDelegate, amount: Int = 0) throws {

        let balance = account.cash

        let spender = Spender(balance)

        do {
            let newBalance = try spender.spend(amount: amount)
            setBalance(on: account, amount: newBalance)

        } catch {
            throw error
        }
    }
    
    func canDebit(account: WalletHolderDelegate, amount: Int = 0) throws -> Bool {
        return try canDeduct(balance: account.cash, bySpending: amount)
    }


    // MARK: (Private) functions

    private func willAdd(funds: Int, to account: WalletHolderDelegate) {
        account.cash += funds
    }

    private func setBalance(on account: WalletHolderDelegate, amount: Int) {
        account.cash = amount
    }

    private func willDeduct(account: WalletHolderDelegate, amount: Int) {
        account.cash -= amount
    }
}

extension Wallet {
    // can deduct balance by spending amount
    internal func canDeduct(balance: Int, bySpending amount: Int) throws -> Bool {
        guard balance.isPositive else {
            //throw SpendingError.notEnoughFunds(balance)
            throw SpendingMoneyError(reason: .notEnoughFunds(amount: balance))
        }
        guard amount.isPositive else {
            //throw SpendingError.mustBePositive(amount)
            throw SpendingMoneyError(reason: .notEnoughFunds(amount: amount))
        }
        guard ((balance - amount) >= 0) else {
            //throw SpendingError.cannotSpend(amount)
            throw SpendingMoneyError(reason: .notEnoughFunds(amount: amount))
        }
        return true
    }


    // Can add cash?
    internal func canAdd(amount: Int) throws -> Bool {
        guard amount.isPositive else {
           //throw SpendingError.mustBePositive(amount)
            throw SpendingMoneyError(reason: .mustBePositive)
        }
        return true
    }

}

