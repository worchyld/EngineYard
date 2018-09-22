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

        d1.orderBook.clear()
        d1.orderBook.add(.existingOrder, values: [3,5,2])
        XCTAssertTrue(d1.orderBook.existingOrders.count == 3)

        let d2 : Deck = d1.copy() as! Deck
        XCTAssertTrue(d1.cards.count == d2.cards.count, "\(d1.cards.count) vs \(d2.cards.count)")
        let lhs = d1.orderBook.existingOrderValues
        let rhs = d2.orderBook.existingOrderValues
        XCTAssertTrue( lhs == rhs , "\(lhs), \(rhs), \(d2.orderBook.description)")


        guard let d2Order = d2.orderBook.existingOrders.first else {
            XCTFail("No order found")
            return
        }

        d2Order.reduce(by: 3)

        XCTAssertTrue(lhs == [3,5,2], "\(lhs)")
        XCTAssertTrue(rhs == [0,5,2], "\(rhs)")

        print ("d1: \(d1.orderBook.description)")
        print ("d2: \(d2.orderBook.description)")
    }
}
