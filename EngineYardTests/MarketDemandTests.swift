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

    func testLazyDecksVarHasContent() {
        let mktDemands = MarketDemand.init(board: board)
        XCTAssertNotNil(mktDemands.decks)
        XCTAssertTrue(mktDemands.decks?.count == Expected.totalDecksInGame)
    }

    func testMarketDemandReturnsZeroGenerations() {
        let mktDemands = MarketDemand.init(board: board)
        let filter = mktDemands.marketFor(locomotiveType: .green)
        XCTAssertTrue(filter.count == 0)
        XCTAssertTrue(mktDemands.howManyGenerationsExist == 0)
    }

    func testAllDecksHaveZeroGenerations() {
        //let mktDemands = MarketDemand.init(board: board)

    }
}
