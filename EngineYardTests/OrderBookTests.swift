//
//  OrderBookTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderBookTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCapacity() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        // attempt to add more random values than capacity
        for _ in 0...(firstDeck.capacity * 2) {
            firstDeck.orderBook.add(.existingOrder)
        }

        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == firstDeck.capacity)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .existingOrder)) // I should not be allowed to add existing orders
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .completedOrder)) // I should not be allowed to add completed orders

        // empty all and try with specific values
        firstDeck.orderBook.clear()

        let overfill = [1,2,3,4,5,6,7,8,9,10]
        firstDeck.orderBook.add(.existingOrder, values: overfill)

        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == firstDeck.capacity)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .existingOrder)) // I should not be allowed to add existing orders
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .completedOrder)) // I should not be allowed to add completed orders

        var idx = 1
        for order in firstDeck.existingOrders {
            XCTAssertTrue(order == idx)
            idx += 1
        }
    }

    func testFill() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        firstDeck.orderBook.fill(.existingOrder)
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == firstDeck.capacity)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .existingOrder)) // I should not be allowed to add existing orders
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .completedOrder)) // I should not be allowed to add completed orders
    }

    func testDidAddRandomValue() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        XCTAssertTrue(firstDeck.capacity == 3)
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 1)
        XCTAssertFalse(firstDeck.orderBook.hasMaximumDice)
        print (firstDeck.description)
    }

    func testDidAddSingleValue() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        firstDeck.orderBook.clear() // force removing to test single value
        firstDeck.orderBook.add(.existingOrder, values: [1])

        XCTAssertTrue(firstDeck.capacity == 3)
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 1)
        XCTAssertFalse(firstDeck.orderBook.hasMaximumDice)

        XCTAssertTrue(firstDeck.orderBook.existingOrders.first?.value == 1)
    }

    func testDidAddMultipleValues() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        firstDeck.orderBook.clear() // force removing to test single value
        firstDeck.orderBook.add(.existingOrder, values: [3,5,2])

        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == firstDeck.capacity)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .existingOrder)) // I should not be allowed to add existing orders
        XCTAssertFalse(firstDeck.orderBook.canAdd(orderType: .completedOrder)) // I should not be allowed to add completed orders

        XCTAssertTrue(firstDeck.orderBook.existingOrderValues == [3,5,2])
    }

    func testDidTransferOrder() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        firstDeck.orderBook.clear() // force removing to test single value
        firstDeck.orderBook.add(.existingOrder, values: [3,5,2])

        guard let order = firstDeck.orderBook.existingOrders.first else {
            XCTFail("No first order found")
            return
        }

        firstDeck.orderBook.transfer(order: order)

        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 2)
        XCTAssertTrue(firstDeck.orderBook.completedOrders.count == 1)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)

        XCTAssertTrue(firstDeck.orderBook.existingOrderValues == [5,2])
        XCTAssertTrue(firstDeck.orderBook.completedOrderValues == [3])
    }

    

}
