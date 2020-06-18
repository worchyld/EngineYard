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
