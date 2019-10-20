//
//  HandTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 20/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class HandTests: EngineYardTests {

    var game: GameModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let mockPlayers = SetupManager.createPlayers(howMany: 5) else {
            XCTFail("Invalid player creation")
            return
        }
        guard let gameObj = SetupManager.instance.setup(players: mockPlayers) else {
            XCTFail("no game")
            return
        }
        self.game = gameObj
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Expect: Cannot add duplicate card
    func testAddDuplicateCard() {
        guard let game = self.game else {
            XCTFail("No game")
            return
        }
        guard let board = game.board else {
            XCTFail("No board")
            return
        }
        guard let players: [Player] = game.players as? [Player] else {
            XCTFail("No players")
            return
        }
        guard let firstPlayer: Player = players.first else {
            XCTFail("No first player")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck")
            return
        }
        guard let firstCard = Deck.findFirstUnownedCard(in: firstDeck) else {
            XCTFail("No first card")
            return
        }

        XCTAssertNoThrow(try (firstPlayer.hand.push(card: firstCard)))
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)

        XCTAssertThrowsError(try (firstPlayer.hand.push(card: firstCard)), "Failed") { (error) in
            XCTAssertEqual(error as! HandError, HandError.alreadyHaveCardFromThisDeck)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.owner! == firstPlayer)
    }

    // Expect: Cannot add card from same parent
    func testSameParent() {
        guard let game = self.game else {
            XCTFail("No game")
            return
        }
        guard let board = game.board else {
            XCTFail("No board")
            return
        }
        guard let players: [Player] = game.players as? [Player] else {
            XCTFail("No players")
            return
        }
        guard let firstPlayer: Player = players.first else {
            XCTFail("No first player")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck")
            return
        }
        guard let firstCard = Deck.findFirstUnownedCard(in: firstDeck) else {
            XCTFail("No first card")
            return
        }
        XCTAssertNoThrow(try (firstPlayer.hand.push(card: firstCard)))
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)

        guard let nextCard = Deck.findFirstUnownedCard(in: firstDeck) else {
            XCTFail("No card found")
            return
        }

        XCTAssertThrowsError(try (firstPlayer.hand.push(card: nextCard)), "Failed") { (error) in
            XCTAssertEqual(error as! HandError, HandError.alreadyHaveCardFromThisDeck)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
    }

    // Expect: When all cards in a single deck are owned, the player cannot add card from this deck
    func testNoCardsRemaining() {
        /*
        guard let game = self.game else {
            XCTFail("No game")
            return
        }
        guard let board = game.board else {
            XCTFail("No board")
            return
        }
        guard let players: [Player] = game.players as? [Player] else {
            XCTFail("No players")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck")
            return
        }

        // first deck has 4 cards
        // expect: in a 5-player game, the fifth player gets nothing
        for (playerIndex, player) in players.enumerated() {
            for card in firstDeck.cards {
                if (playerIndex < 5) {
                    XCTAssertNoThrow(try player.hand.push(card: card))
                }
                else {

                    XCTAssertThrowsError(try (player.hand.push(card: card)), "Failed") { (error) in
                        XCTAssertEqual(error as! HandError, HandError.couldNotHandleCard(card: card))
                    }
                }
            }
        }
         */
    }

    // Expect: Wallet test: Don't add card if can't afford it
    func testCannotAffordCard() {
        guard let game = self.game else {
            XCTFail("No game")
            return
        }
        guard let board = game.board else {
            XCTFail("No board")
            return
        }
        guard let players: [Player] = game.players as? [Player] else {
            XCTFail("No players")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player")
            return
        }

        // Get most expensive deck in game
        guard let deck = (board.decks.sorted { (a, b) -> Bool in
            return (a.cost > b.cost)
            }.first) else {
                XCTFail("No cards found")
                return
        }

        XCTAssertThrowsError(try (firstPlayer.wallet.debit(amount: deck.cost)), "Failed") { (error) in
            XCTAssertEqual(error as! WalletError, WalletError.notEnoughFunds)
        }
    }

    // #TODO: Remove card from hand
}
