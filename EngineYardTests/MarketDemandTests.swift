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

        let book = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        book.setDelegate(delegate: firstLoco)

        XCTAssertNoThrow(
            try book.add(.initialOrder)
        )

        XCTAssertTrue(book.count == 1, "\(book.count)")

        book.updateOrders()

        XCTAssertTrue(firstLoco.orders.count == 1, "\(book.count)")
        XCTAssertEqual(firstLoco.orders.count, book.orders.count)

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

        let book = OrderBook.init(capacity: capacity, orders: firstLoco.orders)
        book.setDelegate(delegate: firstLoco)

        XCTAssertTrue(book.isEmpty)

        XCTAssertNoThrow(
            try book.add(.existingOrder)
        )
        book.updateOrders()

        XCTAssertTrue(book.orders.count == 1)
        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertFalse(book.isFull)

        XCTAssertEqual(firstLoco.orders.count, book.orders.count)
    }

    func testMKTDemand_OneGenerationsExist_ForCompletedOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let book = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        book.setDelegate(delegate: firstLoco)

        XCTAssertNoThrow(
            try book.add(.completedOrder)
        )

        XCTAssertTrue(book.orders.count == 1)
        XCTAssertFalse(book.isEmpty)
        XCTAssertFalse(book.isFull)
        XCTAssertTrue(book.orders.count == 1)

        book.updateOrders()

        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertEqual(firstLoco.orders.count, book.orders.count)

        let market = Market.init(with: boardRef)
        XCTAssertTrue(market.green?.count == 1)
        XCTAssertTrue(market.currentMarket?.count == 1)
    }

    func testOneGenerationExists() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let book = OrderBook.init(capacity: firstLoco.orderCapacity)
        book.setDelegate(delegate: firstLoco)

        XCTAssertNoThrow(
            try book.add(.existingOrder)
        )

        XCTAssertTrue(book.orders.count == 1)
        book.updateOrders()

        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertEqual(firstLoco.orders.count, book.orders.count)

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

        let book1 = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        let book2 = OrderBook.init(capacity: secondLoco.orderCapacity, orders: secondLoco.orders)
        book1.setDelegate(delegate: firstLoco)
        book2.setDelegate(delegate: secondLoco)

        XCTAssertNoThrow( try book1.add( .existingOrder) )
        XCTAssertNoThrow( try book2.add( .existingOrder) )
        XCTAssertTrue( book1.orders.count == 1 )
        XCTAssertTrue( book2.orders.count == 1 )

        book1.updateOrders()
        book2.updateOrders()

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

        let book1 = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        let book2 = OrderBook.init(capacity: secondLoco.orderCapacity, orders: secondLoco.orders)
        let book3 = OrderBook.init(capacity: thirdLoco.orderCapacity, orders: thirdLoco.orders)

        book1.setDelegate(delegate: firstLoco)
        book2.setDelegate(delegate: secondLoco)
        book3.setDelegate(delegate: thirdLoco)

        XCTAssertNoThrow( try book1.add( .existingOrder) )
        XCTAssertNoThrow( try book2.add( .existingOrder) )
        XCTAssertNoThrow( try book3.add( .existingOrder) )

        XCTAssertTrue( book1.orders.count == 1 )
        XCTAssertTrue( book2.orders.count == 1 )
        XCTAssertTrue( book3.orders.count == 1 )

        book1.updateOrders()
        book2.updateOrders()
        book3.updateOrders()

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
                book.setDelegate(delegate: element)
                try book.add(.existingOrder)
                book.updateOrders()

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

    func testRerollOrders() {
        let boardRef = self.locomotives
        guard let firstLoco = boardRef.first else {
            XCTFail("No first loco found")
            return
        }
        
        let book = OrderBook.init(with: firstLoco)
        XCTAssertNoThrow( try book.add( .completedOrder) )
        XCTAssertTrue(book.orders.count == 1)
        XCTAssertTrue(firstLoco.orders.count == 0)
        book.updateOrders()
        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertTrue(firstLoco.existingOrders.count == 0)
        XCTAssertTrue(firstLoco.completedOrders.count == 1)
        XCTAssertNil(firstLoco.initialOrder)
        
        XCTAssertNoThrow( try book.rerollCompletedOrders() )
        book.updateOrders()
        XCTAssertTrue(firstLoco.orders.count == 1)
        XCTAssertTrue(firstLoco.existingOrders.count == 0)
        XCTAssertTrue(firstLoco.completedOrders.count == 1)
        XCTAssertNil(firstLoco.initialOrder)

    }

}
