//
//  CopyTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class CopyTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCopyDeck() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let d1 = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        XCTAssertTrue(d1.orderBook.existingOrders.count == 1)

        let d2 : Deck = d1.copy() as! Deck

        XCTAssertTrue(d2.cards.count == d1.cards.count)
        

        d2.orderBook.clear()

        XCTAssertTrue(d1.orderBook.existingOrders.count == 1)
        XCTAssertTrue(d2.orderBook.existingOrders.count == 0)


    }
}
