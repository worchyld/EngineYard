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

    func testOrderBookOrdersIsEmpty() {
        let orderBook = OrderBook.init(capacity: 3)
        XCTAssertTrue(orderBook.isEmpty)
        XCTAssertTrue(orderBook.orders.count == 0)
    }

    func testOrderBookHasSingleOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )
        XCTAssertNotNil(orderBook.orders)
        XCTAssertTrue(orderBook.count == 1)
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

        XCTAssertFalse(orderBook.orders.isEmpty)
        XCTAssertTrue(orderBook.count == 3)

        let totalExistingOrders = orderBook.orders.filter { (order: Order) -> Bool in
            return (order.state == .existingOrder)
        }.count

        let totalCompletedOrders = orderBook.orders.filter { (order: Order) -> Bool in
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

        XCTAssertTrue(orderBook.count == capacity)
        XCTAssertTrue(orderBook.isFull)
    }

    func testDidChangeOrderStateToCompleted() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertTrue(orderBook.count == 1)

        guard let firstOrder = orderBook.orders.first else {
            XCTFail("No first order found")
            return
        }
        XCTAssertTrue(firstOrder.state == .existingOrder)

        XCTAssertNoThrow(
            try orderBook.transfer(order: firstOrder, to: .completedOrder)
        )

        XCTAssertTrue(firstOrder.state == .completedOrder)
    }

    func testDidReduceOrderValue() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertTrue(!orderBook.isEmpty)
        XCTAssertTrue(orderBook.orders.count == 1)

        guard let firstOrder = orderBook.orders.first else {
            XCTFail("No first order defined")
            return
        }
        XCTAssertNoThrow(
            try firstOrder.setValue(6)
        )
        XCTAssertTrue(firstOrder.value == 6)
        XCTAssertNoThrow(
            try orderBook.decrease(order: firstOrder, by: 1)
        )
        XCTAssertTrue(firstOrder.value == 5, "Expected: 5, Found: \(firstOrder.value)")
    }


    func testCanOnlyAddOneInitialOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        XCTAssertTrue(orderBook.isEmpty)
        XCTAssertTrue(orderBook.orders.count == 0)

        XCTAssertNoThrow(
            try orderBook.add(.initialOrder)
        )

        XCTAssertFalse(orderBook.isEmpty)
        XCTAssertTrue(orderBook.orders.count == 1)

        // check against initial orders
        let initialOrders = orderBook.filter(on: .initialOrder)
        XCTAssertNotNil(initialOrders)
        XCTAssertTrue(initialOrders?.count == 1)

        // Try to add another initial order, should fail
        XCTAssertThrowsError(
            try orderBook.add(.initialOrder)
        )

        XCTAssertTrue(orderBook.filter(on: .initialOrder)?.count == 1)
    }

    func testRerollCompletedOrders() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        }
        XCTAssertTrue(orderBook.orders.count == capacity)
        XCTAssertTrue(orderBook.filter(on: .completedOrder)?.count == capacity)
        XCTAssertTrue(orderBook.filter(on: .initialOrder)?.count == 0)
        XCTAssertTrue(orderBook.filter(on: .existingOrder)?.count == 0)

        XCTAssertNoThrow(try orderBook.rerollCompletedOrders())
        XCTAssertTrue(orderBook.filter(on: .completedOrder)?.count == capacity)
        XCTAssertTrue(orderBook.orders.count == capacity)
        XCTAssertTrue(orderBook.isFull)
        XCTAssertFalse(orderBook.isEmpty)
    }

    func testRerollAndTransfer() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        }

        XCTAssertNoThrow(try orderBook.rerollCompletedOrders())
        XCTAssertNoThrow(try orderBook.transferCompletedOrdersToExisting())

        XCTAssertTrue(orderBook.orders.count == capacity)
        XCTAssertTrue(orderBook.filter(on: .completedOrder)?.count == 0)
        XCTAssertTrue(orderBook.filter(on: .initialOrder)?.count == 0)
        XCTAssertTrue(orderBook.filter(on: .existingOrder)?.count == capacity)
    }

    func testRerollAndTransferInitialStateFails() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Should only add 1 initial order
        for index in 0...(capacity - 1) {
            if (index == 0) {
                XCTAssertNoThrow( try orderBook.add(.initialOrder) )
            }
            else {
                XCTAssertThrowsError(try orderBook.add(.initialOrder)) { error in
                    XCTAssertEqual(error as! OrderBookError, OrderBookError.alreadyHasInitialOrder)
                }
            }
        }

        // Expected: .completedOrder
        XCTAssertThrowsError(try orderBook.rerollCompletedOrders()) { error in
           XCTAssertEqual(error as! OrderBookError, OrderBookError.noOrdersFoundWithState(.completedOrder))
        }

        // Expected: .completedOrder
        XCTAssertThrowsError(try orderBook.transferCompletedOrdersToExisting()) { error in
           XCTAssertEqual(error as! OrderBookError, OrderBookError.noOrdersFoundWithState(.completedOrder))
        }
    }

    func testRerollAndTransferExistingStateFails() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow( try orderBook.add(.existingOrder) )
        }

        // Expected: .completedOrder
        XCTAssertThrowsError(try orderBook.rerollCompletedOrders()) { error in
           XCTAssertEqual(error as! OrderBookError, OrderBookError.noOrdersFoundWithState(.completedOrder))
        }

        // Expected: .completedOrder
        XCTAssertThrowsError(try orderBook.transferCompletedOrdersToExisting()) { error in
           XCTAssertEqual(error as! OrderBookError, OrderBookError.noOrdersFoundWithState(.completedOrder))
        }
    }

    func testPrunableOrdersEqualsOrderSize() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Should only add 1 initial order
        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        }

        XCTAssertTrue( orderBook.filter(on: .completedOrder)?.count == capacity)
        XCTAssertTrue( orderBook.filter(on: .existingOrder)?.count == 0 )
        XCTAssertTrue( orderBook.filter(on: .initialOrder)?.count == 0)

        print ("\n")
        for (index, o) in orderBook.orders.enumerated() {
            print ("index #\(index), \(o.id), value: \(o.value), \(o.state as Any)")
        }
        print ("\n")

        XCTAssertNotNil( orderBook.getOrdersToPrune )
        guard let prunableOrders = orderBook.getOrdersToPrune() else {
            XCTFail("No orders to prune)")
            return
        }
        XCTAssertTrue(prunableOrders.count == orderBook.orders.count)
    }

    func testPrunableOrdersOnInitialOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.initialOrder) )
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(orderBook.filter(on: .initialOrder)?.count == 1)

        // Try to run prunable orders on initialOrder returns nil
        XCTAssertNil( orderBook.getOrdersToPrune() )
    }

    func testPrunableOrdersOnExistingOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.existingOrder) )
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(orderBook.filter(on: .existingOrder)?.count == 1)

        // Try to run prunable orders on existingOrder returns 1 result
        XCTAssertNotNil( orderBook.getOrdersToPrune() )

        guard let prunableOrders = orderBook.getOrdersToPrune() else {
            XCTFail("no prunable orders found")
            return
        }

        XCTAssertTrue(prunableOrders.count == 1)
        XCTAssertTrue(prunableOrders == orderBook.orders)

        print ("\n")
        for (index, o) in prunableOrders.enumerated() {
            print ("index #\(index), \(o.id), value: \(o.value), \(o.state as Any)")
        }
        print ("\n")

    }
}
