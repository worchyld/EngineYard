//
//  BoardUnlockTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardUnlockTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUnlockNextDeck() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No firstdeck found")
            return
        }

        XCTAssertTrue(board.countUnlocked == 1, "\(board.countUnlocked)")

        firstDeck.notifySubscribers()

        XCTAssertTrue(board.countUnlocked == 2, "\(board.countUnlocked)")

        let results = board.decks.reduce(0) {
            $0 + ($1.orderBook.existingOrderValues.count > 0 ? 1: 0)
        }

        XCTAssertTrue(results == 2, "Results: \(results)")

        let _ = board.decks.enumerated().map {
            ( index, element) in
            let orders = element.orderBook.existingOrderValues.count
            let sales = element.orderBook.completedOrderValues.count
            XCTAssertTrue(sales == 0, "\(sales))")
            if (index < 2) {
                XCTAssertTrue(orders > 0, "\(orders)")
            }
            else {
                XCTAssertTrue(orders == 0, "\(orders)")
            }
        }

    }

    func testUnlockAllDecks() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }

        XCTAssertTrue(board.countUnlocked == 1, "\(board.countUnlocked)")

        let _ = board.decks.map({
            $0.notifySubscribers()
        })

        XCTAssertTrue(board.countUnlocked == 14, "\(board.countUnlocked)")

        let _ = board.decks.map({
            let orders = $0.orderBook.existingOrderValues.count
            let sales = $0.orderBook.completedOrderValues.count

            XCTAssertTrue(orders > 0, "\(orders)")
            XCTAssertTrue(sales == 0, "\(sales)")
        })
    }

    func testConstantUnlocking() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck: Deck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        XCTAssertTrue(board.countUnlocked == 1, "\(board.countUnlocked)")

        for _ in 1...14 {
            firstDeck.notifySubscribers()
        }

        XCTAssertTrue(board.countUnlocked == 2, "\(board.countUnlocked)" )

    }

    private func logger() {
        /**
        // LOGGER
        print ("/n---------------")
        for (index, deck) in board.decks.enumerated() {
            print ("index: \(index), \(deck.description)")

            for (idx, card) in deck.cards.enumerated() {
                print ("..idx: \(idx), \(card.description)")

            }
        }
         **/
    }

}
