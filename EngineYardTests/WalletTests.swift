//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWallet_Credit10Coins() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        let amount = 10

        XCTAssertNoThrow(  try interactor.credit(amount: amount) )
        XCTAssertEqual(interactor.balance, amount )

        XCTAssertEqual(interactor.walletHandler?.balance  , interactor.walletHandler?.balance)
    }

    func testWallet_CreditZero_Fails() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        let amount = 0

        XCTAssertThrowsError(try interactor.credit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitZero_Fails() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        let amount = 0

        XCTAssertThrowsError(try interactor.debit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitNegative_Fails() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        let amount = -1

        XCTAssertThrowsError(try interactor.debit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitEqualsZero() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        let amount = 5
        let debit = 5
        let expected = 0

        XCTAssertNoThrow( try interactor.credit(amount: amount) )
        XCTAssertNoThrow( try interactor.debit(amount: debit) )
        XCTAssertEqual(interactor.balance, expected)
    }

    func testWallet_DebitMoreThanFunds_Fails() throws {
        let wallet = Wallet.init()

        let handler = WalletHandler(wallet: wallet)
        let interactor = WalletInteractor(walletHandler: handler)

        // Try to debit more than amount - expect fail
        let amount = 5
        let debit = 10

        XCTAssertNoThrow( try interactor.credit(amount: amount) )

        XCTAssertThrowsError(try interactor.debit(amount: debit) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.cannotSpend(debit) )
        }

        XCTAssertEqual(interactor.balance, amount)
    }

}
