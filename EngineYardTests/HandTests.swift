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

//
//        // Try to add all 4 cards from first train to 5 players;
//        // this should assign 4 players and leave 1 with no card
//
//        for (index, player) in players.enumerated() {
//            print ("#\(index)- Adding to player's hand \(player.name) -- \(player.hand.cards.count)")
//
//            guard let firstCard = Deck.findFirstUnownedCard(in: firstDeck) else {
//                XCTFail("No card found")
//                return
//            }
//
//            if (index < firstDeck.numberOfChildren) {
//                XCTAssertFalse(Hand.containsParent(deck: firstDeck))
//            }
//
//            /*
//            if (index < firstDeck.numberOfChildren) {
//                XCTAssertFalse(Hand.containsParent(deck: firstDeck))
//                XCTAssertTrue(try player.hand.canPush(card: firstCard))
//                XCTAssertNoThrow(try (player.hand.push(card: firstCard)))
//                XCTAssertTrue(player.hand.size == 1)
//
//                let _ = player.hand.cards.map({
//                    XCTAssertNotNil($0.owner)
//                    XCTAssertTrue($0.parent == firstDeck)
//                })
//            }
//            else {
//                XCTAssertFalse(try player.hand.canPush(card: firstCard))
//                XCTAssertTrue(player.hand.size == 0)
//            }*/
//        }
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
