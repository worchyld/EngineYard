//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 05/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SalesTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerfectMatch() {
        let orders = [6]
        let units = 6

        let handler = SalesRuleHandler(orders: orders, units: units)

        XCTAssertEqual(handler.matchType!, MatchType.perfectMatch(0, 0))
    }

    func testLowerMatch() {
        let orders = [6]
        let units = 3

        let handler = SalesRuleHandler(orders: orders, units: units)

        XCTAssertEqual(handler.matchType!, MatchType.lowerMatch(0, 0))
    }

    func testHigherMatch() {
        let orders = [1]
        let units = 3

        let handler = SalesRuleHandler(orders: orders, units: units)

        XCTAssertEqual(handler.matchType!, MatchType.higherMatch(0, 0))
    }

}
