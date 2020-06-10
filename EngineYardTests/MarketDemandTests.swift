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

    func testNumberOfGenerationsExistingIsOne() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }
        guard let firstDeck = board.first else {
            XCTFail("No first deck found")
            return
        }
        guard let deck = firstDeck else {
            XCTFail("No deck found")
            return
        }
        XCTAssertTrue(deck.color == .green)

        XCTAssertTrue(deck.state == .unavailable)

        let order = Order()
        deck.orders.append(order)

        let mktDemand = MarketDemand()
        let results = mktDemand.howManyGenerationsExist(of: Family.Color.green, board: self.board)
        XCTAssertTrue(results == 1)

        XCTAssertTrue(deck.state == .existing) 
    }

}
