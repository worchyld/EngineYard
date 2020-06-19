//
//  SpendingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SpendingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Expected: `mustBePositive` error
    func testSpendNegativeValue_ShouldThrowError() {
        let cash = 10
        let spend = -1

        var w = Wallet(cash)

        XCTAssertThrowsError(try w.spend(amount: spend)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend))
        }

        XCTAssertEqual( w.cash , 10 )
    }

    // Expected: `notEnoughFunds` error
    func testSpendMoreThanFunds_ShouldThrowError() {
        let cash = 10
        let spend = 11

        var w = Wallet(cash)

        XCTAssertThrowsError(try w.spend(amount: spend)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(spend) )
        }

        XCTAssertEqual( w.cash , 10 )
    }

    func testSpendZero_ShouldThrowError() {
        let cash = 10
        let spend = 0

        var w = Wallet(cash)

        XCTAssertThrowsError(try w.spend(amount: spend)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend))
        }

        XCTAssertEqual( w.cash , 10 )
    }

    func testSpendPositive_ShouldPass() {
        let cash = 10
        let spend = 1

        var w = Wallet(cash)

        XCTAssertNoThrow( try w.spend(amount: spend) )
        XCTAssertEqual( w.cash , 9 )
    }
}
