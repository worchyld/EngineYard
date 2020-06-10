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
    func testNoGreenGenerationsExist() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        let mktDemand = MarketDemand.init(board: board)
        let filtered = mktDemand.findDecksWithOrders(matching: .green)
        let exists = Deck.totalGenerations(in: filtered)

        XCTAssertTrue(filtered?.count == 0)
        XCTAssertTrue(exists == 0)
    }

    func testNoGenerationsExist() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        let mktDemand = MarketDemand.init(board: board)

        for familyColor in Family.Color.allCases.enumerated() {
            print ("testing: color \(familyColor.element)")

            let filtered = mktDemand.findDecksWithOrders(matching: familyColor.element)
            let exists = Deck.totalGenerations(in: filtered)

            XCTAssertTrue(filtered?.count == 0)
            XCTAssertTrue(exists == 0)
        }

    }

}
