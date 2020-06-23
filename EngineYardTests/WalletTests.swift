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

    func testWallet_DidCredit10Coins() throws {
        let wallet = WalletHandler()

        let amount = 10

        XCTAssertNoThrow(  try wallet.credit(amount) )
        XCTAssertEqual(wallet.balance, amount )
    }

    func testWallet_CreditZero_Fails() throws {
        let wallet = WalletHandler()
        let amount = 0

        XCTAssertThrowsError(try wallet.credit(amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitZero_Fails() throws {
        let wallet = WalletHandler()
        let amount = 0

        XCTAssertThrowsError(try wallet.debit(amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitNegative_Fails() throws {
        let wallet = WalletHandler()
        let amount = -1

        XCTAssertThrowsError(try wallet.debit(amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitEqualsZero() throws {
        let wallet = WalletHandler()

        let amount = 5
        let debit = 5
        let expected = 0

        XCTAssertNoThrow( try wallet.credit(amount) )
        XCTAssertNoThrow( try wallet.debit(debit) )
        XCTAssertEqual(wallet.balance, expected)
    }

    func testWallet_DebitMoreThanFunds_Fails() throws {
        let wallet = WalletHandler()

        // Try to debit more than amount - expect fail
        let amount = 5
        let debit = 10

        XCTAssertNoThrow( try wallet.credit(amount) )

        XCTAssertThrowsError(try wallet.debit(debit) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.cannotSpend(debit) )
        }

        XCTAssertEqual(wallet.balance, amount)
    }
}
