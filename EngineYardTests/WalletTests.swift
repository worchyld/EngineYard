//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCredit100() {
        let w = Wallet()
        XCTAssertNoThrow(try w.credit(100))
        XCTAssertTrue(w.balance == 100)
    }

    func testCannotCreditNegativeAmount() {
        let w = Wallet()

        XCTAssertThrowsError(try w.credit(-100)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.amountMustBePositive)
        }
        XCTAssertTrue(w.balance == 0)
    }

    func testDebitReturns99() {
        let w = Wallet()
        XCTAssertNoThrow(try w.credit(100))
        XCTAssertTrue(w.balance == 100)
        XCTAssertNoThrow(try w.debit(1))
        XCTAssertTrue(w.balance == 99)
    }

    func testCannotDebitNegativeAmount() {
        let w = Wallet()

        XCTAssertThrowsError(try w.debit(-100)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.amountMustBePositive)
        }
        XCTAssertTrue(w.balance == 0)
    }

    func testCannotDebitMoreThanBalance() {
        let w = Wallet()

        XCTAssertNoThrow(try w.credit(100))

        XCTAssertThrowsError(try w.debit(101)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.notEnoughFunds(100))
        }
        XCTAssertTrue(w.balance == 100)
    }

    func testCanDebitEqualToBalance() {
        let w = Wallet()

        XCTAssertNoThrow(try w.credit(100))
        XCTAssertNoThrow(try w.debit(100))

        XCTAssertTrue(w.balance == 0)
    }

    func testCanAffordFullBalance() {
        let w = Wallet()

        XCTAssertNoThrow(try w.credit(100))
        XCTAssertNoThrow(try w.canAfford(100))
        XCTAssertTrue(try w.canAfford(100))
    }

    func testCannotAffordNegativeAmount() {
        let w = Wallet()

        XCTAssertNoThrow(try w.credit(100))

        XCTAssertThrowsError(try w.debit(-10)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.amountMustBePositive)
        }
        XCTAssertTrue(w.balance == 100)
    }

    func testCannotAffordMoreThanBalance() {
        let w = Wallet()

        XCTAssertNoThrow(try w.credit(100))

        XCTAssertThrowsError(try w.debit(101)) { error in
            XCTAssertEqual(error as! WalletError, WalletError.notEnoughFunds(100))
        }
        XCTAssertTrue(w.balance == 100)
    }


}
