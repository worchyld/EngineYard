//
//  WalletCreditTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletCreditTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
    func testAddNegativeValue_ShouldFail() {
        let cash = 10
        let amount = -1

        var w = Wallet(cash)

        XCTAssertThrowsError(try w.credit(amount: amount)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount))
        }

        XCTAssertEqual( w.cash , 10 )
    }

    func testAddZero_ShouldFail() {
        let cash = 10
        let amount = 0

        var w = Wallet(cash)

        XCTAssertThrowsError(try w.credit(amount: amount)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount))
        }

        XCTAssertEqual( w.cash , 10 )
    }

    func testAddPositiveValue_NoThrow() {
        let cash = 10
        let amount = 1

        var w = Wallet(cash)

        XCTAssertNoThrow( try w.credit(amount: amount) )
        XCTAssertEqual( w.cash , 11 )
    }
 */
}
