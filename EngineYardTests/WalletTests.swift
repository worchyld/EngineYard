//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDebitNotEnoughFunds() {
        let balance = 100
        let amount = 101

        let w = Wallet(balance: balance)

        XCTAssertThrowsError(try w.debit(amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.notEnoughFunds)
        }
    }

    func testDebitNegativeValue() {
        let balance = 100
        let amount = -100

        let w = Wallet(balance: balance)

        XCTAssertThrowsError(try w.debit(amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testDebitExactValue() {
        let balance = 100
        let amount = balance

        let w = Wallet(balance: balance)

        XCTAssertTrue(try w.debit(amount: amount) == 0)
    }

    func testDebitPositiveValue() {
        let balance = 100
        let amount = 5

        let w = Wallet(balance: balance)

        XCTAssertTrue(try w.debit(amount: amount) == 95)
    }

    func testDebitZero() {
        let balance = 0
        let amount = 0

        let w = Wallet(balance: balance)

        XCTAssertThrowsError(try w.debit(amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditZero() {
        let balance = 0
        let amount = 0

        let w = Wallet(balance: balance)

        XCTAssertThrowsError(try w.credit(amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditNegativeValue() {
        let balance = 0
        let amount = -100

        let w = Wallet(balance: balance)

        XCTAssertThrowsError(try w.credit(amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditPositiveValue() {
        let balance = 100
        let creditAmount = balance

        let w = Wallet(balance: balance)

        XCTAssertTrue(try w.credit(amount: creditAmount) == balance * 2)
    }

    func testCreditThenDebit() {
        let openingBalance = 100
        let credit = 50
        let debit = 40
        let w = Wallet(balance: openingBalance)

        XCTAssertTrue(try (w.credit(amount: credit) == 150))

        do {
            let result = try (w.debit(amount: debit))
            XCTAssertTrue(result == 110, "\(String(describing: result))")
        }
        catch {
            XCTFail("\(error)")
        }

        XCTAssertTrue(w.balance == 110)
    }
}
