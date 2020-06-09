//
//  OrderCreationTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderCreationTests: XCTestCase {

    var board: Board?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        self.board = EngineYardGame.loadInitialBoard()
    }

    func testDidCreateSingleExistingOrder() {
        let order = Order()
        XCTAssertNotNil(order.value)
        XCTAssertTrue(order.state.rawValue == Order.State.existingOrder.rawValue)
    }

    func testCanGetFirstDeck() -> Deck? {
        guard let board = self.board else {
            XCTFail("No board defined")
            return nil
        }
        guard let deck = board.first else {
            XCTFail("No deck found")
            return nil
        }
        guard let firstDeck = deck else {
            XCTFail("No first deck found")
            return nil
        }
        XCTAssertNotNil(self.board)
        XCTAssertNotNil(deck)
        return firstDeck
    }

    func testFirstDeckHasNoOrders() {
        guard let firstDeck = self.testCanGetFirstDeck() else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertNil(firstDeck.orders)

        let orderBook = OrderBook.init(capacity: firstDeck.orderCapacity)
        XCTAssertFalse( orderBook.isFull )
        XCTAssertTrue(orderBook.orders.count == 0)
    }

    func testCanAddSingleOrder() {
        guard let firstDeck = self.testCanGetFirstDeck() else {
            XCTFail("No first deck found")
            return
        }

        let orderBook = OrderBook.init(capacity: firstDeck.orderCapacity)

        XCTAssertNoThrow(
            try orderBook.add()
        )

        XCTAssertTrue(orderBook.orders.count == 1)

        guard let firstOrder = orderBook.orders.first else {
            XCTFail("No first order")
            return
        }

        XCTAssertNotNil(firstOrder.value)

    }

    func testCanFillToCapacity() {
        guard let firstDeck = self.testCanGetFirstDeck() else {
            XCTFail("No first deck found")
            return
        }

        let orderBook = OrderBook.init(capacity: firstDeck.orderCapacity)
        XCTAssertTrue(orderBook.orders.count == 0)

        // Force fill the capacity
        for index in 0...(firstDeck.orderCapacity - 1) {
            do {
                try orderBook.add()
            }
            catch {
                print (error)
                XCTFail("Failed at: \(index), \(error as Any), capacity: \(firstDeck.orderCapacity)")
            }
        }

        XCTAssertTrue(firstDeck.orderCapacity == orderBook.orders.count)

        // Try to add 1 more order, should fail
        XCTAssertThrowsError(
            try orderBook.add()
        )

        XCTAssertTrue(firstDeck.orderCapacity == orderBook.orders.count)
    }

}
