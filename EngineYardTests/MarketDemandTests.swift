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
        let market = Market.init(with: boardRef)
        let currentMarket = market.currentMarket
        XCTAssertTrue(currentMarket?.count == 0)
        XCTAssertTrue(market.green?.count == 0)
    }

    func testMKT_NoGenerationsExist() {
        let boardRef = self.locomotives
        let market = Market.init(with: boardRef)
        let currentMarket = market.currentMarket
        XCTAssertTrue(currentMarket?.count == 0)
//
//        for element in Family.Color.allCases {
//            switch element {
//            case .green:
//                XCTAssertTrue(market.green?.count == 0)
//            case .red:
//                continue
//            case .blue:
//                continue
//            case .yellow:
//                continue
//            }
//        }
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

        guard let orderBookOrders = orderBook.orders else {
            XCTFail("orderbook orders fail")
            return
        }

        firstLoco.setOrders(orders: orderBookOrders)

        let market = Market.init(with: boardRef)
        let currentMarket = market.currentMarket

        XCTAssertTrue(currentMarket?.count == 0)
    }


    func testMKTDemand_OneGenerationsExist_ForExistingOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let orderBook = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        guard let orderBookOrders = orderBook.orders else {
            XCTFail("orderbook orders fail")
            return
        }

        XCTAssertTrue(orderBookOrders.count == 1)
        firstLoco.setOrders(orders: orderBookOrders)
        XCTAssertTrue(firstLoco.orders.count == 1)

        let market = Market.init(with: boardRef)

        XCTAssertTrue(market.green?.count == 1)
        XCTAssertTrue(market.currentMarket?.count == 1)
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

        guard let orderBookOrders = orderBook.orders else {
            XCTFail("orderbook orders fail")
            return
        }

        XCTAssertTrue(orderBookOrders.count == 1)
        firstLoco.setOrders(orders: orderBookOrders)
        XCTAssertTrue(firstLoco.orders.count == 1)

        let market = Market.init(with: boardRef)

        XCTAssertTrue(market.green?.count == 1)
        XCTAssertTrue(market.currentMarket?.count == 1)
    }

    func testOneGenerationExists() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let orderBook = OrderBook.init(capacity: firstLoco.orderCapacity, orders: firstLoco.orders)
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )

        guard let orderBookOrders = orderBook.orders else {
            XCTFail("orderbook orders fail")
            return
        }

        XCTAssertTrue(orderBookOrders.count == 1)
        firstLoco.setOrders(orders: orderBookOrders)
        XCTAssertTrue(firstLoco.orders.count == 1)

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
        XCTAssertTrue( orderBook1.orders?.count == 1 )
        XCTAssertTrue( orderBook2.orders?.count == 1 )

        guard let oBook1 = orderBook1.orders else {
            XCTFail("OrderBook failed")
            return
        }
        guard let oBook2 = orderBook2.orders else {
            XCTFail("OrderBook failed")
            return
        }

        firstLoco.setOrders(orders: oBook1)
        secondLoco.setOrders(orders: oBook2)

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

        XCTAssertTrue( orderBook1.orders?.count == 1 )
        XCTAssertTrue( orderBook2.orders?.count == 1 )
        XCTAssertTrue( orderBook3.orders?.count == 1 )

        guard let oBook1 = orderBook1.orders else {
            XCTFail("OrderBook failed")
            return
        }
        guard let oBook2 = orderBook2.orders else {
            XCTFail("OrderBook failed")
            return
        }
        guard let oBook3 = orderBook3.orders else {
            XCTFail("OrderBook failed")
            return
        }

        firstLoco.setOrders(orders: oBook1)
        secondLoco.setOrders(orders: oBook2)
        thirdLoco.setOrders(orders: oBook3)

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
}
