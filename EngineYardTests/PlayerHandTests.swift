//
//  PlayerHandTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PlayerHandTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddCard() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player found")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        // Find the first unowned card in the deck?
        guard let firstCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        do {
            try firstPlayer.hand.add(firstCard)
        } catch let error {
            XCTFail(error.localizedDescription as String)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.owner == firstPlayer)
        XCTAssertTrue(firstDeck.owners?.count == 1)
    }

    func testAddSameCard() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player found")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        // Find the first unowned card in the deck?
        guard let firstCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        do {
            try firstPlayer.hand.add(firstCard)
        } catch let error {
            XCTFail(error.localizedDescription as String)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.owner == firstPlayer)
        XCTAssertTrue(firstDeck.owners?.count == 1)

        // try to add the same card
        // expect it to throw an error (Already have this card)
        XCTAssertThrowsError(try firstPlayer.hand.add(firstCard)) { error in
            XCTAssertEqual(error as? HandError, HandError.sameCardFromThisDeck)
        }
    }

    func testAddCardFromSameDeck() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player found")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        // get first 2 cards from deck
        let cards = firstDeck.cards[0...1]

        guard let firstCard = cards.first else {
            XCTFail("No first card found")
            return
        }
        guard let lastCard = cards.last else {
            XCTFail("No last card found")
            return
        }

        XCTAssertNoThrow(try firstPlayer.hand.add(firstCard), "Error")

        // try to add a card from the same deck
        // expect it to throw an error (Already have this card)
        XCTAssertThrowsError(try firstPlayer.hand.add(lastCard)) { error in
            XCTAssertEqual(error as? HandError, HandError.sameCardFromThisDeck)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstDeck.owners!.count == 1)
    }

    // Try to remove a card from the player's hand
    // Test #1 - Remove a card when hand is empty
    // Test #2 - Add then Remove a card from hand
    // Test #3 - Remove a card that doesn't exist in player's hand
    func testRemoveCard() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player found")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        // get first 2 cards from deck
        let cards = firstDeck.cards[0...1]

        guard let firstCard = cards.first else {
            XCTFail("No first card")
            return
        }

        guard let lastCard = cards.last else {
            XCTFail("No last card")
            return
        }

        // Test #1 - Remove a card when hand is empty
        // Expect: Throw an error (Hand is empty)
        XCTAssertThrowsError(try firstPlayer.hand.remove(firstCard)) { error in
            XCTAssertEqual(error as? HandError, HandError.handIsEmpty)
        }

        // Test #2 - Add then Remove a card from hand
        XCTAssertNoThrow(try firstPlayer.hand.add(firstCard))
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstDeck.owners?.count == 1)

        XCTAssertNoThrow(try firstPlayer.hand.remove(firstCard))

        XCTAssertTrue(firstPlayer.hand.cards.count == 0, "Cards: \(firstPlayer.hand.cards.count)")
        XCTAssertTrue(firstDeck.owners?.count == 0, "\(firstDeck.owners!.count)")

        // Test #3 - Remove a card that doesn't exist in player's hand
        XCTAssertNoThrow(try firstPlayer.hand.add(firstCard))
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstDeck.owners?.count == 1)

        XCTAssertThrowsError(try firstPlayer.hand.remove(lastCard)) { error in
            XCTAssertEqual(error as? HandError, HandError.cannotFindCard)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstDeck.owners?.count == 1)
    }

}
