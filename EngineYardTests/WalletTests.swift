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


    /*

    func testWallet_SpendZero_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = 0

        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend) )
        }

        XCTAssertTrue(wallet.cash == 100)
    }


    func testWallet_SpendNegative_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = -1

        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend) )
        }
    }

    // Cannot go negative
    func testWallet_SpendMoreThanCashOnHand_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = 101
        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(spend) )
        }
    }

    func testWallet_DidSpend10Coins() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let amount = 10

        XCTAssertNoThrow( try debitor.debit(amount: amount) )
        XCTAssertTrue(wallet.cash == 90)
    }

    func testWallet_CannotCreditNegative() {
        let wallet = Wallet.init(100)
        var creditor = WalletCreditInteractor(wallet: wallet)

        let amount = -10

        XCTAssertThrowsError(try creditor.credit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_CannotCreditZero() {
        let wallet = Wallet.init(100)
        var creditor = WalletCreditInteractor(wallet: wallet)

        let amount = 0

        XCTAssertThrowsError(try creditor.credit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DidCredit5Coins() {
        let wallet = Wallet.init(100)
        var creditor = WalletCreditInteractor(wallet: wallet)

        let amount = 5
        XCTAssertNoThrow( try creditor.credit(amount: amount) )
        XCTAssertEqual( wallet.cash , 105)
    }

    func testWallet_CannotDebitZero() {
        let wallet = Wallet.init(100)
        let w = WalletInteractor(wallet: wallet)

        let amount = 0

        XCTAssertThrowsError(try w.debit(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DidDebit() {
        let wallet = Wallet.init(100)
        let w = WalletInteractor(wallet: wallet)

        let amount = 5

        XCTAssertNoThrow( try w.debit(amount: amount) )
        XCTAssertEqual(wallet.cash, 95)
    }

    func testWallet_DidCredit() {
        let wallet = Wallet.init(100)
        let w = WalletInteractor(wallet: wallet)

        let amount = 5

        XCTAssertNoThrow( try w.credit(amount: amount) )
        XCTAssertEqual(wallet.cash, 105)
    }
 */
}
