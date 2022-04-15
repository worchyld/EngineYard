//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/03/2022.
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

    func testCreditWallet() {
        let w = Wallet(100)
        XCTAssertNoThrow(try w.credit(100))
        XCTAssertTrue(w.balance == 200)
    }

    func testDebitWallet() {
        let w = Wallet(100)
        let _ = try! w.credit(150)
        XCTAssertNoThrow(try w.debit(50))
        XCTAssertTrue(w.balance == 200)
    }
    
    func testCreditCannotBeNegative() {
        let w = Wallet()
        let amount = -50
        XCTAssertThrowsError(try w.credit(amount)) { error in
            XCTAssertEqual(error as? NumericErrorDelegate, NumericErrorDelegate.cannotBeNegative)
        }
//
//
//        XCTAssertThrowsError(try Production.costToShift(amount: 1, from: firstRedCard, to: firstGreenCard)) { error in
//            XCTAssertEqual(error as? ProductionError, ProductionError.cannotUpgradeDownstream)
//
//
//        XCTAssertThrowsError(try Hand.costToShift(amount: 1, from: firstRedCard, to: firstGreenCard)) { error in
//            XCTAssertEqual(error as? HandError, HandError.cannotSelectDownstream)
//        }
    }
    
    func testDebitCannotBeNegative() {
        let w = Wallet()
        let amount = -50
        XCTAssertThrowsError(try w.debit(amount)) { error in
            XCTAssertEqual(error as? NumericErrorDelegate, NumericErrorDelegate.cannotBeNegative)
        }
    }
    
    func testDebitBalanceIsNotEnoughToCoverAmount() {
        let amount = 50
        let w = Wallet(25)
        
        XCTAssertThrowsError(try w.debit(amount)) { error in
            XCTAssertEqual(error as? NumericErrorDelegate, NumericErrorDelegate.notEnoughFunds)
        }
    }
    
}
