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
            XCTAssertEqual(error as! WalletError, WalletError.mustBePositive)
        }
        XCTAssertTrue(w.balance == 0)
    }
}
