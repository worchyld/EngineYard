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
    func testGreenGenerationsExistIsZero() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        let results = Deck.howManyGenerationsExist(in: board, matching: .green)
        XCTAssertTrue(results == 0)
        XCTAssertNotNil(board)
        XCTAssertTrue(board.count == Expected.totalDecksInGame)
    }

    /*
    func testAllGenerationsExistIsZero() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        for color in Family.Color.allCases.enumerated() {
            let results = Deck.howManyGenerationsExist(in: board, matching: color.element)
            XCTAssertTrue(results == 0)
        }
    }

    func testGreenGenerationsExistingIsOne() {
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

        let _ = MarketDemand(board: board)
        let results = Deck.howManyGenerationsExist(in: board, matching: .green)

        XCTAssertTrue(results == 1)
        XCTAssertTrue(deck.state == .existing)

        for color in Family.Color.allCases.enumerated() {
            let results = Deck.howManyGenerationsExist(in: board, matching: color.element)

            switch color.element {
            case .green:
                XCTAssertTrue(results == 1)
            default:
                XCTAssertTrue(results == 0)
            }
        }
    }*/

}
