//
//  SpendingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Testing the Spending struct

class SpendingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCannotSpendZero() throws {
        var spender = Spender(0)

        XCTAssertThrowsError(  try spender.spend(amount: 0) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(0) )
        }
    }

    func testCannotSpendNegative() throws {
        var spender = Spender()

        XCTAssertThrowsError(  try spender.spend(amount: -1) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(-1) )
        }
    }

    func testCannotSpendMoreThanFunds() throws {
        var spender = Spender(3)

        XCTAssertThrowsError(  try spender.spend(amount: 5) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.cannotSpend(5) )
        }
    }

    func testDidSpendToZero() throws {
        let amount = 3
        var spender = Spender(amount)

        let result = try spender.spend(amount: amount)

        XCTAssertEqual(result, 0)
    }

}
