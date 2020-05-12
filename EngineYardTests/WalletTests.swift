//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: XCTestCase {

    func testInitializeWallet() {
        let w = Wallet(balance: 100)
        XCTAssertTrue(w.balance == 100)
    }

    func testCreditWallet() {
        let w = Wallet(balance: 100)
        XCTAssertNoThrow(try w.credit(amount: 100))
        XCTAssertTrue(w.balance == 200)
    }

    func testDebitWallet() {
        let w = Wallet(balance: 100)
        let _ = try! w.credit(amount: 150)
        XCTAssertNoThrow(try w.debit(amount: 50))
        XCTAssertTrue(w.balance == 200)
    }
}
