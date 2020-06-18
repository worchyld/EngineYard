//
//  RerollOrdersTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class RerollOrdersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
