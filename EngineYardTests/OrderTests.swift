//
//  OrderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testOrdersAreEmpty() {
        let locomotives = Locomotive.build()
        let _ = locomotives.map { (loco: Locomotive) -> Void in
            XCTAssertTrue(loco.orders.count == 0)
        }
    }

    func testOrderDidCreate() {
        let order = Order.init()
        XCTAssertTrue(order.state == .existingOrder)
        XCTAssertTrue(order.value > 0 && order.value < 7)
    }

    func testOrderDidReduceBy1() {
        var order = Order.init()
        XCTAssertNoThrow(
            try order.setValue(6)
        )
        XCTAssertTrue(order.state == .existingOrder)
        XCTAssertTrue(order.value == 6)

        XCTAssertNoThrow(
            try order.reduceValue(by: 1)
        )
        XCTAssertTrue(order.value == 5)
    }

    func testOrderDidReduceBy5() {
        var order = Order.init()
        XCTAssertNoThrow(
            try order.setValue(6)
        )
        XCTAssertNoThrow(
            try order.reduceValue(by: 5)
        )

        XCTAssertTrue(order.value == 1)
    }

    func testOrderDidReduceToZero() {
        var order = Order.init()
        XCTAssertNoThrow(
            try order.setValue(2)
        )
        XCTAssertNoThrow(
            try order.reduceValue(by: 1)
        )

        XCTAssertTrue(order.value == 1)

        XCTAssertNoThrow(
            try order.reduceValue(by: 1)
        )

        XCTAssertTrue(order.value == 0)
    }

    func testOrderCannotGoNegative() {
        var order = Order.init()
        XCTAssertNoThrow(
            try order.setValue(0)
        )
        XCTAssertThrowsError(
            try order.reduceValue(by: 1)
        )
    }

    func testOrderCannotReduceCompletedOrder() {
        var order = Order.init(.completedOrder)
        XCTAssertThrowsError(
            try order.reduceValue(by: 1)
        )
    }
}
