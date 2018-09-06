//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 05/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

fileprivate class MockOrder {
    var orders: [Int]
    var units: Int

    init(orders: [Int], units: Int) {
        self.orders = orders
        self.units = units
    }
}

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

        XCTAssertNotNil(handler.matchObj)
        XCTAssertEqual(handler.matchObj?.type, SalesMatchType.perfectMatch)
        XCTAssertEqual(handler.matchObj?.type, <#T##expression2: Equatable##Equatable#>)
    }

    func testLowerMatch() {
        let orders = [6]
        let units = 3

        //let handler = SalesRuleHandler(orders: orders, units: units)
        //XCTAssertEqual(handler.matchType!, MatchType.lowerMatch(0, 0))
    }

    func testHigherMatch() {
        let orders = [1]
        let units = 3

        //let handler = SalesRuleHandler(orders: orders, units: units)
        //XCTAssertEqual(handler.matchType!, MatchType.higherMatch(0, 0))
    }



}
