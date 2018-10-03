//
//  GameBoardSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 29/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameBoardSetupTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBoardInitialSeed() {
        let board = Board()
        board.prepare()
        XCTAssertTrue(board.decks.count == 14)
        XCTAssertTrue(board.countUnlocked == 0)
    }

    func testFivePlayerSetup() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }

        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }

        guard let _ = game.players else {
            XCTFail("No players initialised")
            return
        }


        XCTAssertTrue(players.count == 5, "Invalid player count: \(players.count)")
        XCTAssertTrue(board.countUnlocked == 1, "Invalid board unlocks \(board.countUnlocked)")

        // ----------------------------------
        // In a 5-player game, I expect:
        // (1) Each player to have $14
        // (2) No player has any cards
        // (3) Expect no owners
        // (4) Green.1 has 1 order & unlocked
        // (5) All other locomotives are locked, with no orders
        // ----------------------------------


        // (1) Expect cash == $14
        // (2) Expect no player to have any cards
        _ = players.map({
            XCTAssertTrue( $0.cash == Rules.NumberOfPlayers.fivePlayerSeedCash )
            XCTAssertTrue( $0.hand.cards.count == 0, "\($0) has cards \($0.hand.description)")
        })

        for (index, d) in board.decks.enumerated() {

            // (3) Expect no owners
            XCTAssertTrue(d.owners?.count == 0, "\(d.name) has \(String(describing: d.owners?.count)) owners")

            if (index == 0) {
                // (4) Green.1 has 1 order
                XCTAssertTrue(d.color == .green && d.generation == .first)
                XCTAssertTrue(d.orderBook.existingOrderValues.count == 1, "Orders: \(d.orderBook.existingOrderValues.count)")
                XCTAssertTrue(d.active, "Deck \(d.name) is inactive")
            }
            else {
                // (5) All other locomotives are locked, with no orders
                XCTAssertFalse(d.active, "Deck \(d.name) is active")
                XCTAssertTrue(d.orderBook.existingOrderValues.count == 0, "Orders: \(d.orderBook.existingOrderValues.count)")
                XCTAssertTrue(d.orderBook.completedOrderValues.count == 0, "Orders: \(d.orderBook.completedOrderValues.count)")
            }
        }
    }

    func testThreePlayerSetup() {
        let players = Mock.players(howMany: 3)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }

        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }

        guard let _ = game.players else {
            XCTFail("No players initialised")
            return
        }

        XCTAssertTrue(players.count == 3, "Invalid player count: \(players.count)")
        XCTAssertTrue(board.countUnlocked == 2, "Invalid board unlocks \(board.countUnlocked)")

        // ----------------------------------
        // In a 3-player game, I expect:
        // (1) Each player to have $12
        // (2) Expect 3 owners of Green.1
        // (3) Expect only 3 cards to be owned
        // (4) Expect Green.1 to have 3 orders
        // (5) Expect Red.1 to have 1 order
        // (6) Expect all others to have 0 orders
        // ----------------------------------
        
        // (1) Expect cash == $12
        _ = players.map({
            XCTAssertTrue( $0.cash == Rules.NumberOfPlayers.threePlayerSeedCash )
        })

        let decks = board.decks[0...1]

        guard let firstDeck = decks.first else {
            return
        }
        guard let lastDeck = decks.last else {
            return
        }

        XCTAssertTrue(firstDeck.color == .green && firstDeck.generation == .first)
        XCTAssertTrue(lastDeck.color == .red && lastDeck.generation == .first)

        // (2) Expect 3 owners of Green.1
        XCTAssertTrue(firstDeck.owners?.count == 3, "Invalid owners: \(String(describing: firstDeck.owners!.count))")

        for (index, c) in firstDeck.cards.enumerated() {
            if (index < 3) {
                XCTAssertNotNil(c.owner, "Should have owner")
            }
            else {
                XCTAssertNil(c.owner, "Invalid owner set")
            }
        }

        // (3) Expect only 3 cards to be owned
        var totalOwned = 0
        for d in board.decks {
            totalOwned += d.owners?.count ?? 0
        }
        XCTAssertTrue(totalOwned == 3, "Expected: 3 owners. Actual: \(totalOwned)")


        // (6) Expect all decks to have 0 sales
        let _ = board.decks.map {
            XCTAssertTrue($0.orderBook.completedOrderValues.count == 0, "Invalid completed orders: \(firstDeck.orderBook.completedOrderValues.count)")
        }

        for (index, deck) in board.decks.enumerated() {
            for _ in deck.cards {
                let orders = deck.orderBook.existingOrderValues
                switch (index) {
                case 0:
                    // (4) Expect Green.1 to have 3 orders
                    XCTAssertTrue(orders.count == 3, "Deck: \(deck.name) has \(orders.count) orders")
                case 1:
                    // (5) Expect Red.1 to have 1 order
                    XCTAssertTrue(orders.count == 1, "Deck: \(deck.name) has \(orders.count) orders")
                default:
                    // (6) Expect all others to have 0 orders
                    XCTAssertTrue(orders.count == 0, "Deck: \(deck.name) has \(orders.count) orders")
                }
            }
        }




    }

}
