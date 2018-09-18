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
        let units = 3
        let orders = [3]

        let handler = SalesCaseHandler(units, orders)
        handler.analyse()

        XCTAssertTrue(handler.unitsSold == units)
        XCTAssertTrue(handler.orders.first! == 0)
        XCTAssertTrue(handler.units == 0)
    }

    func testLowerMatch() {
        let units = 1
        let orders = [6]

        let handler = SalesCaseHandler(units, orders)
        handler.analyse()

        let remainingUnits = (orders.first! - units)

        XCTAssertTrue(handler.unitsSold == units)
        XCTAssertTrue(handler.units == 0)
        XCTAssertTrue(handler.orders.first! == remainingUnits)
    }

    func testHigherMatch() {
        let units: Int = 5
        let orders: [Int] = [4]

        let unitsSold: Int = {
            return orders.first! as Int
        }()

        let handler = SalesCaseHandler(units, orders)
        handler.analyse()

        let expectedOrders : Int = {
            var order:Int = orders.first! as Int
            order -= order
            return order
        }()

        XCTAssertTrue(handler.unitsSold == unitsSold, "\(handler.unitsSold) vs \(unitsSold)")
        XCTAssertTrue(handler.orders.first! == expectedOrders, "\(handler.orders.first!) vs \(expectedOrders)")
    }


}
