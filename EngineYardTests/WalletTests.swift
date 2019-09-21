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

        let w = Wallet()

        XCTAssertThrowsError(try w.debit(balance: balance, amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.notEnoughFunds)
        }
    }

    func testDebitNegativeValue() {
        let balance = 100
        let amount = -100

        let w = Wallet()

        XCTAssertThrowsError(try w.debit(balance: balance, amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testDebitExactValue() {
        let balance = 100
        let amount = balance

        let w = Wallet()

        XCTAssertTrue(try w.debit(balance: balance, amount: amount) == 0)
    }

    func testDebitZero() {
        let balance = 0
        let amount = 0

        let w = Wallet()

        XCTAssertThrowsError(try w.debit(balance: balance, amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditZero() {
        let balance = 0
        let amount = 0

        let w = Wallet()

        XCTAssertThrowsError(try w.credit(balance: balance, amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditNegativeValue() {
        let balance = 0
        let amount = -100

        let w = Wallet()

        XCTAssertThrowsError(try w.credit(balance: balance, amount: amount)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
    }

    func testCreditPositiveValue() {
        let balance = 100
        let amount = balance

        let w = Wallet()

        XCTAssertTrue(try w.credit(balance: balance, amount: amount) == balance * 2)
    }
}
