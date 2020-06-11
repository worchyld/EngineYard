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

    var board: Board!

    override func setUpWithError() throws {
        guard let board = EngineYardGame.loadInitialBoard() else {
            XCTFail("No board created")
            return
        }
        self.board = board
    }

    func testLazyLocoVarHasContent() {
        let mktDemands = MarketDemand.init(board: board)
        XCTAssertNotNil(mktDemands.locos)
        XCTAssertTrue(mktDemands.locos?.count == Expected.totalLocomotivesInGame)
    }

    func testMarketDemandReturnsZeroGenerations() {
        let mktDemands = MarketDemand.init(board: board)
        let filter = mktDemands.marketFor(locomotiveType: .green)
        XCTAssertTrue(filter.count == 0)
        XCTAssertTrue(mktDemands.howManyGenerationsExist == 0)
    }

    func testAllDecksHaveZeroGenerations() {
        let mktDemands = MarketDemand.init(board: board)

        for element in Family.Color.allCases {
            let filter = mktDemands.marketFor(locomotiveType: element)
            XCTAssertTrue(filter.count == 0)
            XCTAssertTrue(mktDemands.howManyGenerationsExist == 0)
        }
    }

    func testOneGenerationExists() {
        guard let loco = board.first else {
            XCTFail("No locomotive found")
            return
        }
        let order = Order.init()
        loco?.orders.append(order)
        XCTAssertTrue(loco?.orders.count == 1)

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
}
