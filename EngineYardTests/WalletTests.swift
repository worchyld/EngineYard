//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 14/04/2018.
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
        let wallet = Wallet.init(balance: 100)
        XCTAssertTrue(wallet.canDebit(amount: 100))
        XCTAssertFalse(wallet.canDebit(amount: 101))
        XCTAssertFalse(wallet.canDebit(amount: -99))
        XCTAssertFalse(wallet.canDebit(amount: -101))

        wallet.credit(amount: 100)
        XCTAssert(wallet.balance == 200)
    }

    func testDebit() {
        let wallet = Wallet.init(balance: 100)
        XCTAssertTrue(wallet.canCredit(amount: 99))
        XCTAssertFalse(wallet.canCredit(amount: -100))
        XCTAssertFalse(wallet.canCredit(amount: -1))

        wallet.debit(amount: 100)
        XCTAssert(wallet.balance == 0)
    }

    func testTax() {
        // when cash is 20, expect tax to be 2
        let wallet = Wallet(balance: 20)
        let taxDue = Tax.calculateTaxDue(onBalance: wallet.balance)
        wallet.debit(amount: taxDue)

        XCTAssertTrue(taxDue == 2, "Expected: 2. Returned \(taxDue)")
        XCTAssertTrue(wallet.balance == 18, "Expected: 18. Returned \(wallet.balance)")
    }
    
}
