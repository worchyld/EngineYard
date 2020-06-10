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

    // When board has been initialised
    func testNumberOfGenerationsExistIsZero() {
        let mktDemand = MarketDemand()
        let results = mktDemand.howManyGenerationsExist(of: Family.Color.green, board: self.board)
        XCTAssertTrue(results == 0)
        XCTAssertNotNil(board)
        XCTAssertTrue(board.count == Expected.totalDecksInGame)
    }

}
