//
//  OrderBookTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderBookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testOrderBookOrdersAreNil() {
        let orderBook = OrderBook.init(capacity: 3)
        XCTAssertNil(orderBook.orders)
    }

    func testOrderBookHasSingleOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )
        XCTAssertNotNil(orderBook.orders)

        guard let orders = orderBook.orders else {
            XCTFail("Orders do not exist")
            return
        }

        XCTAssertTrue(orders.count == 1)
        XCTAssertTrue(orders.capacity == capacity)
    }

    func testDidAddMixedOrderTypesToOrderBook() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertNoThrow(
            try orderBook.add(.completedOrder)
        )

        XCTAssertNoThrow(
            try orderBook.add(.completedOrder)
        )

        guard let orders = orderBook.orders else {
            XCTFail("No orders")
            return
        }

        XCTAssertTrue(orders.count == 3)

        let totalExistingOrders = orders.filter { (order: Order) -> Bool in
            return (order.state == .existingOrder)
        }.count

        let totalCompletedOrders = orders.filter { (order: Order) -> Bool in
            return (order.state == .completedOrder)
        }.count

        XCTAssertTrue(totalExistingOrders == 1)
        XCTAssertTrue(totalCompletedOrders == 2)
        XCTAssertTrue(orderBook.isFull)
    }

    func testOrderBookCannotExceedCapacity() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow(
                try orderBook.add(.existingOrder)
            )
        }

        // Shouldn't be able to add a `existingOrder` when full
        XCTAssertThrowsError(
            try orderBook.add(.existingOrder)
        )

        // Shouldn't be able to add a `completedOrder` when full
        XCTAssertThrowsError(
            try orderBook.add(.completedOrder)
        )

        guard let orders = orderBook.orders else {
            XCTFail("Orders do not exist")
            return
        }

        XCTAssertTrue(orders.count == capacity)
        XCTAssertTrue(orderBook.isFull)
    }

    func testDidChangeOrderStateToCompleted() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        guard let orders = orderBook.orders else {
            XCTFail("Orders do not exist")
            return
        }

        XCTAssertTrue(orders.count == 1)

        guard var firstOrder = orders.first else {
            XCTFail("No first order found")
            return
        }
        XCTAssertTrue(firstOrder.state == .existingOrder)

        XCTAssertNoThrow(
            try orderBook.transfer(order: &firstOrder, to: .completedOrder)
        )

        XCTAssertTrue(firstOrder.state == .completedOrder)
    }

    func testDidReduceOrderValue() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertNotNil(orderBook.orders)
        guard let orders = orderBook.orders else {
            XCTFail("No orders defined")
            return
        }
        guard var firstOrder = orders.first else {
            XCTFail("No first order defined")
            return
        }
        XCTAssertNoThrow(
            try firstOrder.setValue(6)
        )
        XCTAssertTrue(firstOrder.value == 6)
        XCTAssertNoThrow(
            try orderBook.reduce(order: &firstOrder, by: 1)
        )
        XCTAssertTrue(firstOrder.value == 5, "Expected: 5, Found: \(firstOrder.value)")
    }

}
