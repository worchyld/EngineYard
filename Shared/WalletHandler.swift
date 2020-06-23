//
//  WalletHandler.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


protocol WalletUseCase : CreditUseCase, DebitUseCase  {
    var wallet: Wallet { get }
    var balance: Int { get }
}
protocol CreditUseCase {
    func credit(_ amount: Int) throws
}
protocol DebitUseCase {
    func debit(_ amount: Int) throws
}


class WalletHandler : WalletUseCase {
    internal var wallet: Wallet

    var balance: Int {
        return self.wallet.cash
    }

    init(_ balance: Int = 0) {
        precondition(balance >= 0, "Balance must be >= 0")

        self.wallet = Wallet(balance)
    }
}


extension WalletHandler : CreditUseCase {
    func credit(_ amount: Int) throws {
        if try canCredit(amount) {
            self.wallet.cash += amount
        }
    }
    private func canCredit(_ amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }
}

extension WalletHandler : DebitUseCase {
    func debit(_ amount: Int) throws {
        if try canDebit(amount) {
            self.wallet.cash -= amount
        }
    }

    private func canDebit(_ amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }

        let balance = self.balance

        guard ((balance - amount) >= 0) else {
            throw SpendingError.cannotSpend(amount)
        }

        return true
    }
}

/**

protocol WalletUseCase {
    var wallet: Wallet { get }
    var balance: Int { get }
    var creditDelegate: CreditUseCase? { get }
    var debitDelegate: DebitUseCase?  { get }
}

protocol CreditUseCase {
    func credit(amount: Int) throws
}
protocol DebitUseCase {
    func debit(amount: Int) throws
}

protocol WalletCreditUseCase {
    func credit(walletHandler: WalletUseCase, amount: Int) throws
}
protocol WalletDebitUseCase {
    func debit(walletHandler: WalletUseCase, amount: Int) throws
}

/*
 * Protocol that defines the Interactor's use case.
 */
protocol WalletInteractorInput: class, CreditUseCase, DebitUseCase {
    var walletHandler: WalletUseCase? { get }
    var creditHandler: WalletCreditUseCase? { get }
    var debitHandler: WalletDebitUseCase? { get }

    var balance: Int { get }
}

class WalletHandler : WalletUseCase {
    private(set) internal var wallet: Wallet
    private(set) var creditDelegate: CreditUseCase?
    private(set) var debitDelegate: DebitUseCase?

    var balance: Int {
        return self.wallet.cash
    }

    init(wallet: Wallet) {
        self.wallet = wallet
        self.creditDelegate = self
        self.debitDelegate = self
    }
}

extension WalletHandler : CreditUseCase {
    func credit(amount: Int) {
        self.wallet.cash += amount
    }
}

extension WalletHandler : DebitUseCase {
    func debit(amount: Int) {
        self.wallet.cash -= amount
    }
}

/*
 * The Interactor responsible for implementing
 * the business logic of the module.
 */
class WalletInteractor : WalletInteractorInput {
    internal var walletHandler: WalletUseCase?
    internal var creditHandler: WalletCreditUseCase?
    internal var debitHandler: WalletDebitUseCase?

    var balance: Int {
        return walletHandler?.balance ?? 0
    }

    init(walletHandler: WalletUseCase) {
        self.walletHandler = walletHandler
        self.creditHandler = CreditUseCaseHandler()
        self.debitHandler = DebitUseCaseHandler()
    }

    func credit(amount: Int) throws {
        guard let handler = self.walletHandler else {
            return
        }
        guard let creditHandler = creditHandler else {
            return
        }

        do {
            try creditHandler.credit(walletHandler: handler, amount: amount)
        } catch {
            throw error
        }
    }

    func debit(amount: Int) throws {
        guard let handler = self.walletHandler else {
            return
        }
        guard let debitHandler = debitHandler else {
            return
        }
        do {
            try debitHandler.debit(walletHandler: handler, amount: amount)
        }
        catch {
            throw error
        }

    }
}





// Credit Handler
class CreditUseCaseHandler : WalletCreditUseCase {
    func credit(walletHandler: WalletUseCase, amount: Int) throws {
        do {
            if try canCredit(walletHandler: walletHandler, amount: amount) {
                try walletHandler.creditDelegate?.credit(amount: amount)
            }
        }
        catch {
            throw error
        }
    }

    
    func canCredit(walletHandler: WalletUseCase, amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        return true
    }
}

// Debit Handler
class DebitUseCaseHandler : WalletDebitUseCase {
    func debit(walletHandler: WalletUseCase, amount: Int) throws {
        do {
            if try canDebit(walletHandler: walletHandler, amount: amount) {
                try walletHandler.debitDelegate?.debit(amount: amount)
            }
        }
        catch {
            throw error
        }
    }

    func canDebit(walletHandler: WalletUseCase, amount: Int) throws -> Bool {
        guard amount.isPositive else {
            throw SpendingError.mustBePositive(amount)
        }
        let balance = walletHandler.balance

        guard ((balance - amount) >= 0) else {
            throw SpendingError.cannotSpend(amount)
        }

        return true
    }
}
**/
