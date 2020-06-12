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


//        guard let board = board else {
//            return
//        }
//        guard let firstLoco = board?.first else {
//            return
//        }
//
//        let order = Order.init()
//        firstLoco.orders.append(order)
//        XCTAssertTrue(firstLoco.orders.count == 1)
//
//        let mktDemands = MarketDemand.init(board: board)
//        let report = mktDemands.runReport(for: firstLoco.color)
//        XCTAssertNotNil(report)
//        XCTAssertTrue(report?.total == 1, "Report finds: \(report?.total as Any)")
//    }

        /*

    func testOneGenerationExists() {
        guard let board = board else {
            return
        }
        guard let firstLoco = board?.first else {
            return
        }

        let order = Order.init()
        firstLoco.orders.append(order)
        XCTAssertTrue(firstLoco.orders.count == 1)

        let mktDemands = MarketDemand.init(board: board)
        let greenMkt = mktDemands.marketFor(locomotiveType: .green)
        let redMkt = mktDemands.marketFor(locomotiveType: .red)
        let yellowMkt = mktDemands.marketFor(locomotiveType: .yellow)
        let blueMkt = mktDemands.marketFor(locomotiveType: .blue)

        XCTAssertTrue(greenMkt.count == 1)
        XCTAssertTrue(redMkt.count == 0)
        XCTAssertTrue(yellowMkt.count == 0)
        XCTAssertTrue(blueMkt.count == 0)
    }

    func testTwoGenerationsExists() {
        guard let board = board else {
            return
        }
        guard let greenLocos = board.filtered(on: .green) else {
            XCTFail("No green locos found")
            return
        }

        XCTAssertTrue(greenLocos.count == 5)

        // Only assign orders to the first 2 green locos
        for (index, element) in greenLocos.enumerated() {
            if (index < 2) {
                let order = Order.init()
                element.orders.append(order)
            }
            else {
                break
            }
        }

        let mktDemands = MarketDemand.init(board: board)
        let greenMkt = mktDemands.marketFor(locomotiveType: .green)
        let redMkt = mktDemands.marketFor(locomotiveType: .red)
        let yellowMkt = mktDemands.marketFor(locomotiveType: .yellow)
        let blueMkt = mktDemands.marketFor(locomotiveType: .blue)

        XCTAssertTrue(greenMkt.count == 2)
        XCTAssertTrue(redMkt.count == 0)
        XCTAssertTrue(yellowMkt.count == 0)
        XCTAssertTrue(blueMkt.count == 0)

    }
 */
}
