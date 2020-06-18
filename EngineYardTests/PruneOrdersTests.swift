//
//  PruneOrdersTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PruneOrdersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPrunableOrdersAtCapacity() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // fill the book with completed orders
        for _ in 0...(capacity - 1) {
            XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        }

        XCTAssertTrue( orderBook.filter(on: .completedOrder)?.count == capacity)
        XCTAssertTrue( orderBook.filter(on: .existingOrder)?.count == 0 )
        XCTAssertTrue( orderBook.filter(on: .initialOrder)?.count == 0)

        debugPrint(orders: orderBook.orders)

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
    }

    // :didPrune Tests
    func testDidPruneOneCompletedOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(orderBook.filter(on: .completedOrder)?.count == 1)

        orderBook.pruneOrders()
        XCTAssertTrue(orderBook.orders.count == 0)
        XCTAssertTrue(orderBook.isEmpty)
    }

    func testDidNotPruneWhenEmptyOrders() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)
        XCTAssertTrue(orderBook.orders.count == 0)

        // Get pruneable orders, expect 0 or nil
        XCTAssertNil( orderBook.getOrdersToPrune() )

        // If we fire pruneOrders, expect nothing to happen
        orderBook.pruneOrders()
    }

    func testDidNotPruneInitialOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.initialOrder) )
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(orderBook.filter(on: .initialOrder)?.count == 1)

        orderBook.pruneOrders()
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertFalse(orderBook.isEmpty)
    }

    func testDidPruneOneExistingOrder() {
        let capacity = 3
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.existingOrder) )
        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(orderBook.filter(on: .existingOrder)?.count == 1)

        orderBook.pruneOrders()
        XCTAssertTrue(orderBook.orders.count == 0)
        XCTAssertTrue(orderBook.isEmpty)
    }

    func testDidPruneWithMixedOrders() {
        // if orders are: existingOrders: [n1, n2] and completedOrders: [n3,n4]
        // prune.expect: existingOrders: [n1,n2], completedOrders = [n4]

        let capacity = 4
        let orderBook = OrderBook.init(capacity: capacity)

        // Add 1 initial order
        XCTAssertNoThrow( try orderBook.add(.existingOrder) )
        XCTAssertNoThrow( try orderBook.add(.existingOrder) )
        XCTAssertNoThrow( try orderBook.add(.completedOrder) )
        XCTAssertNoThrow( try orderBook.add(.completedOrder) )

        XCTAssertTrue( orderBook.filter(on: .existingOrder)?.count == 2 )
        XCTAssertTrue( orderBook.filter(on: .completedOrder)?.count == 2 )
        XCTAssertTrue( orderBook.filter(on: .initialOrder)?.count == 0 )
        XCTAssertTrue( orderBook.orders.count == 4 )

        // Get prunable orders and test it
        XCTAssertNotNil( orderBook.getOrdersToPrune() )
        guard let prunableOrders = orderBook.getOrdersToPrune() else {
            XCTFail("no prunable orders found")
            return
        }
        guard let filteredCompletedOrders = orderBook.filter(on: .completedOrder) else {
            XCTFail("no completed orders found")
            return
        }

        XCTAssertTrue(prunableOrders.count == 2)

        for (index, prunableOrder) in prunableOrders.enumerated() {
            let completedOrder = filteredCompletedOrders[index]
            XCTAssertEqual(completedOrder, prunableOrder)
        }

        orderBook.pruneOrders()

        let existingOrders = orderBook.filter(on: .existingOrder)
        let completedOrders = orderBook.filter(on: .completedOrder)
        let initialOrders = orderBook.filter(on: .initialOrder)

        XCTAssertTrue( existingOrders?.count == 2 ,  "Expected 2. Got: \(existingOrders?.count ?? 0)")
        XCTAssertTrue( completedOrders?.count == 1, "Expected 1. Got: \(completedOrders?.count ?? 0)" )
        XCTAssertTrue( initialOrders?.count == 0, "Expected 0. Got \(initialOrders?.count ?? 0)" )
        XCTAssertTrue( orderBook.orders.count == 3 )

    }
}


extension PruneOrdersTests {
    private func debugPrint(orders: [Order]) {
        print ("\n")
        for (index, o) in orders.enumerated() {
            print ("index #\(index), \(o.id), value: \(o.value), \(o.state as Any)")
        }
        print ("\n")
    }
}
