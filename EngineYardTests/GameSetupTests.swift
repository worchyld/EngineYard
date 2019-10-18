//
//  GameSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 04/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameSetupTests: EngineYardTests {

    var game: GameModel?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.game = GameModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // # Tests for a 3 player game
    // Each player has 12 coins
    // Each player has 1x First Generation Green card with 1 unit
    // First two decks are considered active
    // First deck has 3 orders in a `active` state
    // First deck has 3 owners (3 player game).  Other cards in this deck must have 0 owners.
    // Second deck has 1 order in a `active` state
    // Only 2 decks should have owners, orders and be `active`    
    func testThreePlayerGameSetup() {
        let playerCount = 3

        guard let _ = Mock.players(howMany: playerCount) else {
            XCTFail("No players created")
            return
        }
        
        guard let mockPlayers: [Player] = SetupManager.createPlayers(howMany: playerCount) else {
            XCTFail("Invalid player creation")
            return
        }
        XCTAssertTrue(mockPlayers.count == playerCount)
        guard let game = SetupManager.instance.setup(players: mockPlayers) else {
            XCTFail("no game")
            return
        }
        XCTAssertNotNil(game)
        XCTAssertNotNil(game.players)

        guard let board = game.board else {
            XCTFail("No board found")
            return
        }

        let decksWithOrders = board.decks.filter({
            return ($0.orders.count > 0)
        })
        let activeDecks = board.decks.filter({
            return ($0.state == .active)
        })

        XCTAssertTrue(decksWithOrders.count == 2)
        XCTAssertTrue(activeDecks.count == 2)

        guard let firstDeck = decksWithOrders.first else {
            XCTFail("No first deck")
            return
        }
        guard let secondDeck = decksWithOrders.last else {
            XCTFail("No second deck")
            return
        }
        XCTAssertTrue(firstDeck.orders.count == 3)
        XCTAssertTrue(firstDeck.state == .active)
        XCTAssertTrue(secondDeck.orders.count == 1)
        XCTAssertTrue(secondDeck.state == .active)

        // Player testing
        guard let players = game.players else {
            XCTFail("No players defined")
            return
        }

        XCTAssertTrue(players.count == 3)

        let _ = players.map({
            let p = ($0 as! Player)
            XCTAssertTrue(p.cash == Constants.threePlayerSeedCash, "Expected: \(Constants.threePlayerSeedCash). Actual: \(p.cash)")
            XCTAssertTrue(p.hand.cards.count == 1)
        })

        for (index, card) in firstDeck.cards.enumerated() {
            print ("index: \(index), card: \(card), units: \(card.units) self.owner: \(card.owner?.description ?? "None" )")
            if (index < 3) {
                XCTAssertNotNil(card.owner)
                XCTAssertTrue(card.units == 1)
            }
            else {
                XCTAssertNil(card.owner)
                XCTAssertTrue(card.units == 0)
            }

            XCTAssertTrue(card.parent?.generation == .first)
            XCTAssertTrue(card.parent?.color == .green)
        }
    }

    // # Tests for a 5 player game:
    // + Each player has 14 coins.
    // + No player should have any cards && no cards should have any owners.
    // + First deck gets 1 order and be considered `active`
    // + 1 deck should be `active` (first deck)
    // + No deck should have any owners
    func testFivePlayerSetup() {
        let playerCount = 5

        guard let _ = Mock.players(howMany: playerCount) else {
            XCTFail("No players created")
            return
        }

        guard let mockPlayers: [Player] = SetupManager.createPlayers(howMany: playerCount) else {
            XCTFail("Invalid player creation")
            return
        }
        XCTAssertTrue(mockPlayers.count == playerCount)
        guard let game = SetupManager.instance.setup(players: mockPlayers) else {
            XCTFail("no game")
            return
        }
        XCTAssertNotNil(game)
        XCTAssertNotNil(game.players)

        guard let board = game.board else {
            XCTFail("No board found")
            return
        }

        let decksWithOrders = board.decks.filter({
            return ($0.orders.count > 0)
        })
        let activeDecks = board.decks.filter({
            return ($0.state == .active)
        })

        XCTAssertTrue(decksWithOrders.count == 1)
        XCTAssertTrue(activeDecks.count == 1)

        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck")
            return
        }

        XCTAssertTrue(firstDeck.orders.count == 1)

        let _ = board.decks.map({
            XCTAssertTrue($0.owners?.count == 0)
        })

        // Player testing
        guard let players = game.players else {
            XCTFail("No players defined")
            return
        }

        XCTAssertTrue(players.count == 5)

        let _ = players.map({
            let p = ($0 as! Player)
            XCTAssertTrue(p.cash == Constants.fivePlayerSeedCash, "Expected: \(Constants.fivePlayerSeedCash). Actual: \(p.cash)")
            XCTAssertTrue(p.hand.cards.count == 0)
        })

    }

}
