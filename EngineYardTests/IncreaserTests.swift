//
//  IncreaserTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests against the Increment class
class IncreaserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCannotIncrementZero() throws {
        let increaser = Increaser()
        let amount = 0

        XCTAssertThrowsError(  try increaser.increase(by: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(0) )
        }
    }

    func testCannotIncrementNegativeInt() throws {
        let increaser = Increaser()
        let amount = -1

        XCTAssertThrowsError(  try increaser.increase(by: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(-1) )
        }
    }

    func testCanIncreasePositiveInt() throws {
        var amount = 1
        let increaser = Increaser(amount)

        amount = try increaser.increase(by: 4)

        XCTAssertEqual(amount, 5)
    }
    
}
