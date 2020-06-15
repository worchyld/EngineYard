//
//  MarketDemandTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 10/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class MarketDemandTests: XCTestCase {

    private var board: Board?

    private lazy var locomotives : [Locomotive] = {
        guard let b = self.board else {
            XCTFail("No board")
            return []
        }
        guard let board = b else {
            XCTFail("No board")
            return []
        }
        return board
    }()

    override func setUpWithError() throws {
        guard let board = EngineYardGame.loadInitialBoard() else {
            XCTFail("No board created")
            return
        }
        self.board = board
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        board = nil
    }

    func testLocomotives() {
        let boardRef = self.locomotives
        XCTAssertTrue(boardRef.count == Expected.totalLocomotivesInGame)
    }

    func testMKT_GreenHasNoGenerations() {
        let boardRef = self.locomotives

        // Market should be empty
        let market = Market.init(with: boardRef)
        let currentMarket = market.currentMarket
        XCTAssertTrue(currentMarket?.count == 0)
        XCTAssertTrue(market.green?.count == 0)
    }

    func testMKTDemand_NoGenerationsExist_ForInitialOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let orderBook = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        XCTAssertNoThrow(
            try orderBook.add(.initialOrder)
        )

        XCTAssertTrue(orderBook.count == 1, "\(orderBook.count)")

        firstLoco.updateOrders(from: orderBook)
        XCTAssertTrue(firstLoco.orders.count == 1, "\(orderBook.count)")

        XCTAssertEqual(firstLoco.orders.count, orderBook.orders.count)

        let market = Market.init(with: boardRef)
        let currentMarket = market.currentMarket

        XCTAssertTrue(currentMarket?.count == 0)
    }

    func testMKTDemand_OneGenerationsExist_ForExistingOrder() {
        let boardRef = self.locomotives
        guard let firstLoco = boardRef.first else {
            XCTFail("No first loco found")
            return
        }
        let capacity = firstLoco.orderCapacity

        let orderBook = OrderBook.init(capacity: capacity, orders: firstLoco.orders)
        XCTAssertTrue(orderBook.isEmpty)

        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertTrue(firstLoco.orders.count == 0)
        XCTAssertFalse(orderBook.isFull)

        firstLoco.updateOrders(from: orderBook)

        XCTAssertEqual(firstLoco.orders.count, orderBook.orders.count)
    }

    func testMKTDemand_OneGenerationsExist_ForCompletedOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let orderBook = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        XCTAssertNoThrow(
            try orderBook.add(.completedOrder)
        )

        XCTAssertTrue(orderBook.orders.count == 1)
        XCTAssertFalse(orderBook.isEmpty)
        XCTAssertFalse(orderBook.isFull)


        XCTAssertTrue(orderBook.orders.count == 1)
        firstLoco.updateOrders(from: orderBook)
        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertEqual(firstLoco.orders.count, orderBook.orders.count)

        let market = Market.init(with: boardRef)

        XCTAssertTrue(market.green?.count == 1)
        XCTAssertTrue(market.currentMarket?.count == 1)
    }

    func testOneGenerationExists() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let orderBook = OrderBook.init(capacity: firstLoco.orderCapacity)
        
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        XCTAssertTrue(orderBook.orders.count == 1)
        firstLoco.updateOrders(from: orderBook)
        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertEqual(firstLoco.orders.count, orderBook.orders.count)

        // Get market, expected: green to have 1 generation existing
        let market = Market.init(with: boardRef)
        XCTAssertTrue(market.green?.count == 1)
        XCTAssertTrue(market.red?.count == 0)
        XCTAssertTrue(market.yellow?.count == 0)
        XCTAssertTrue(market.blue?.count == 0)
        XCTAssertTrue(market.currentMarket?.count == 1)
    }

    func testTwoGenerationsExist() {
        let boardRef = self.locomotives

        // Get all green generations
        guard let filter = Locomotive.filter(locomotives: boardRef, on: .green) else {
           XCTFail("Filter failed")
           return
        }

        XCTAssertTrue(filter.count == 5)

        let firstLoco = filter[0]
        let secondLoco = filter[1]

        XCTAssertTrue(firstLoco.color == .green && firstLoco.generation.rawValue == 1)
        XCTAssertTrue(secondLoco.color == .green && secondLoco.generation.rawValue == 2)
        XCTAssertTrue(firstLoco.orders.count == 0)
        XCTAssertTrue(secondLoco.orders.count == 0)

        let orderBook1 = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        let orderBook2 = OrderBook.init(capacity: secondLoco.orderCapacity, orders: secondLoco.orders)

        XCTAssertNoThrow( try orderBook1.add( .existingOrder) )
        XCTAssertNoThrow( try orderBook2.add( .existingOrder) )
        XCTAssertTrue( orderBook1.orders.count == 1 )
        XCTAssertTrue( orderBook2.orders.count == 1 )

        firstLoco.updateOrders(from: orderBook1)
        secondLoco.updateOrders(from: orderBook2)

        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertTrue(secondLoco.orders.count == 1)

        // Test the market, should find 2 green generations
        let market = Market.init(with: boardRef)
        XCTAssertTrue(market.green?.count == 2)
        XCTAssertTrue(market.red?.count == 0)
        XCTAssertTrue(market.yellow?.count == 0)
        XCTAssertTrue(market.blue?.count == 0)
        XCTAssertTrue(market.currentMarket?.count == 2)
    }


    func testThreeGenerationsExist() {
        let boardRef = self.locomotives

        // Get all green generations
        guard let filter = Locomotive.filter(locomotives: boardRef, on: .green) else {
           XCTFail("Filter failed")
           return
        }

        XCTAssertTrue(filter.count == 5)

        let firstLoco = filter[0]
        let secondLoco = filter[1]
        let thirdLoco = filter[2]

        XCTAssertTrue(firstLoco.color == .green && firstLoco.generation.rawValue == 1)
        XCTAssertTrue(secondLoco.color == .green && secondLoco.generation.rawValue == 2)
        XCTAssertTrue(thirdLoco.color == .green && thirdLoco.generation.rawValue == 3)
        XCTAssertTrue(firstLoco.orders.count == 0)
        XCTAssertTrue(secondLoco.orders.count == 0)
        XCTAssertTrue(thirdLoco.orders.count == 0)

        let orderBook1 = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        let orderBook2 = OrderBook.init(capacity: secondLoco.orderCapacity, orders: secondLoco.orders)
        let orderBook3 = OrderBook.init(capacity: thirdLoco.orderCapacity, orders: thirdLoco.orders)

        XCTAssertNoThrow( try orderBook1.add( .existingOrder) )
        XCTAssertNoThrow( try orderBook2.add( .existingOrder) )
        XCTAssertNoThrow( try orderBook3.add( .existingOrder) )

        XCTAssertTrue( orderBook1.orders.count == 1 )
        XCTAssertTrue( orderBook2.orders.count == 1 )
        XCTAssertTrue( orderBook3.orders.count == 1 )

        firstLoco.updateOrders(from: orderBook1)
        secondLoco.updateOrders(from: orderBook2)
        thirdLoco.updateOrders(from: orderBook3)

        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertTrue(secondLoco.orders.count == 1)
        XCTAssertTrue(thirdLoco.orders.count == 1)

        // Test the market, should find 3 green generations
        let market = Market.init(with: boardRef)
        XCTAssertTrue(market.green?.count == 3)
        XCTAssertTrue(market.red?.count == 0)
        XCTAssertTrue(market.yellow?.count == 0)
        XCTAssertTrue(market.blue?.count == 0)
        XCTAssertTrue(market.currentMarket?.count == 3)
    }


    // Test 10 locomotives
    // Expected:
    //  3 green generations
    //  3 red generations
    //  2 blue generations
    //  2 yellow generations
    func testTenLocos_HasExpectedMarket() {
        let boardRef = self.locomotives

        for (index, element) in boardRef.enumerated() {
            if (index > 9) {
                break
            }

            do {
                let book = OrderBook.init(capacity: element.orderCapacity, orders: element.orders)
                try book.add(.existingOrder)
                element.updateOrders(from: book)

                XCTAssertTrue(element.orders.count == 1)
                XCTAssertTrue(element.existingOrders.count == 1)

            } catch {
                XCTFail("Error -- \(error as Any)")
                break
            }
        }

        // Test the market
        // Expected:
        //  3 green generations
        //  3 red generations
        //  2 blue generations
        //  2 yellow generations
        let market = Market.init(with: boardRef)
        XCTAssertTrue(market.green?.count == 3, "Found: \(String(describing: market.green?.count))")
        XCTAssertTrue(market.red?.count == 3, "Found: \(String(describing: market.red?.count))")
        XCTAssertTrue(market.blue?.count == 2, "Found: \(String(describing: market.blue?.count))")
        XCTAssertTrue(market.yellow?.count == 2, "Found: \(String(describing: market.yellow?.count))")
        XCTAssertTrue(market.currentMarket?.count == 10, "Found: \(String(describing: market.currentMarket?.count))")
    }

}
