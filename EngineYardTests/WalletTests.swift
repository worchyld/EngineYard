//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCredit() {
        let w = Wallet()

        XCTAssertThrowsError(try w.credit(amount: -100)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.mustBePositive)
        }

        XCTAssertTrue(w.balance == 0)
    }

    func testDebit() {
        let w = Wallet()

        XCTAssertTrue(w.balance == 0)

        XCTAssertThrowsError(try w.debit(amount: -100)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.mustBePositive)
        }

        XCTAssertThrowsError(try w.debit(amount: 100)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.notEnoughFunds)
        }

        do {
            try w.credit(amount: 100)
        } catch let error {
            XCTFail(error.localizedDescription)
        }

        // debit 0 should throw error
        XCTAssertThrowsError(try w.debit(amount: 0)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.mustBePositive)
        }

        // debit > balance should throw error
        XCTAssertThrowsError(try w.debit(amount: 101)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.notEnoughFunds)
        }

        // debit $1 should not throw error
        XCTAssertNoThrow(try w.debit(amount: 1))

        // balance should be 100-1 = $99
        XCTAssertTrue(w.balance == 99)
    }

    
}
