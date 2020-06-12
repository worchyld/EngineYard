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

    func testMKTDemand_GreenHasNoGenerations() {
        let boardRef = self.locomotives

        let gen = GenerationsExist(with: boardRef, find: .green)
        let report = gen.report()
        XCTAssertNotNil(report)
        XCTAssertTrue(report?.count == 0)
    }

    func testMKTDemand_AllDecksHasNoGenerations() {
        let boardRef = self.locomotives

        for element in Family.Color.allCases {
            let gen = GenerationsExist(with: boardRef, find: element)
            let report = gen.report()
            XCTAssertNotNil(report)
            XCTAssertTrue(report?.count == 0)
        }
    }

    func testMKTDemand_NoGenerationsExist_WhenInitialOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let order = Order.init(.initialOrder)
        firstLoco.orders.append(order)

        let gen = GenerationsExist(with: boardRef, find: firstLoco.color)
        let report = gen.report()
        XCTAssertNotNil(report)
        XCTAssertTrue(report?.count == 0)
    }

    func testMKTDemand_OneGenerationsExist_WhenExistingOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let order = Order.init(.existingOrder)
        firstLoco.orders.append(order)


        let gen = GenerationsExist(with: boardRef, find: firstLoco.color)
        let report = gen.report()
        XCTAssertNotNil(report)
        XCTAssertTrue(report?.count == 1)
    }

    func testMKTDemand_OneGenerationsExist_WhenCompletedOrder() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let order = Order.init(.completedOrder)
        firstLoco.orders.append(order)


        let gen = GenerationsExist(with: boardRef, find: firstLoco.color)
        let report = gen.report()
        XCTAssertNotNil(report)
        XCTAssertTrue(report?.count == 1)
    }

    func testOneGenerationExists() {
        let boardRef = self.locomotives

        guard let firstLoco = boardRef.first else {
            return
        }

        let order = Order.init(.existingOrder)
        firstLoco.orders.append(order)

        let greenMkt = GenerationsExist(with: boardRef, find: .green)
        let redMkt = GenerationsExist(with: boardRef, find: .red)
        let yellowMkt = GenerationsExist(with: boardRef, find: .blue)
        let blueMkt = GenerationsExist(with: boardRef, find: .yellow)

        XCTAssertTrue(greenMkt.report()?.count == 1)
        XCTAssertTrue(redMkt.report()?.count == 0)
        XCTAssertTrue(yellowMkt.report()?.count == 0)
        XCTAssertTrue(blueMkt.report()?.count == 0)
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

        let order1 = Order.init(.existingOrder)
        let order2 = Order.init(.existingOrder)

        firstLoco.orders.append(order1)
        secondLoco.orders.append(order2)

        let greenMkt = GenerationsExist(with: boardRef, find: .green)
        let yellowMkt = GenerationsExist(with: boardRef, find: .yellow)
        let redMkt = GenerationsExist(with: boardRef, find: .red)
        let blueMkt = GenerationsExist(with: boardRef, find: .blue)

        XCTAssertTrue(greenMkt.report()?.count == 2)
        XCTAssertTrue(yellowMkt.report()?.count == 0)
        XCTAssertTrue(redMkt.report()?.count == 0)
        XCTAssertTrue(blueMkt.report()?.count == 0)
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

        let order1 = Order.init(.existingOrder)
        let order2 = Order.init(.existingOrder)
        let order3 = Order.init(.existingOrder)

        firstLoco.orders.append(order1)
        secondLoco.orders.append(order2)
        thirdLoco.orders.append(order3)

        let greenMkt = GenerationsExist(with: boardRef, find: .green)
        let yellowMkt = GenerationsExist(with: boardRef, find: .yellow)
        let redMkt = GenerationsExist(with: boardRef, find: .red)
        let blueMkt = GenerationsExist(with: boardRef, find: .blue)

        XCTAssertTrue(greenMkt.report()?.count == 3)
        XCTAssertTrue(yellowMkt.report()?.count == 0)
        XCTAssertTrue(redMkt.report()?.count == 0)
        XCTAssertTrue(blueMkt.report()?.count == 0)

    }
}
