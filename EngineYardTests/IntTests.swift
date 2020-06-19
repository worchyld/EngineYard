//
//  IntTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Test against custom extensions

class IntTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Tests against Int Extension: `isPositive`
    func testNegativeValue_PostiveCheckExpectFalse() {
        let value = -1
        XCTAssertFalse(value.isPositive)
    }

    func testZeroValue_PositiveCheckExpectFalse() {
        let value = 0
        XCTAssertFalse(value.isPositive)
    }

    func testPositiveValue_PositiveCheckExpectTrue() {
        let value = 1
        XCTAssertTrue(value.isPositive)
    }


    // Tests against Int Extension: `isNegative`
    func testNegativeValue_NegativeCheckExpectTrue() {
        let value = -1
        XCTAssertTrue(value.isNegative)
    }

    func testZeroValue_NegativeCheckExpectFalse() {
        let value = 0
        XCTAssertFalse(value.isNegative)
    }


    func testPositiveValue_NegativeCheckExpectFalse() {
        let value = 1
        XCTAssertFalse(value.isNegative)
    }

}
