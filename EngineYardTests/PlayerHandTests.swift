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
            XCTAssertEqual(error as? HandError, HandError.handAlreadyHasCard)
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
            XCTAssertEqual(error as? HandError, HandError.handAlreadyHasCard)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstDeck.owners!.count == 1)
    }


    /**
    func testAddCardToPlayersHand() {
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

        let result = firstDeck.owners?.filter({ (p: Player) -> Bool in
            return (p == firstPlayer)
        }).count

        XCTAssertTrue(result == 0, "\(firstPlayer.name) is an owner of a card in \(firstDeck.name), \(result?.description ?? "N/A")")

        // Find the first unowned card in the deck?
        guard let firstCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        XCTAssertNil(firstCard.owner, "This card is owned by \(firstCard.owner?.description ?? "N/A")")

        firstDeck.notifySubscribers() // unlock the next deck
        let _ = firstPlayer.hand.add(firstCard)

        XCTAssertTrue(firstCard.owner == firstPlayer)
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.production.units == 1)
        XCTAssertTrue(firstCard.production.spentUnits == 0)
        XCTAssertTrue(firstDeck.owners?.count == 1)


        // Expect the first 2 decks to have orders
        for (index, d) in board.decks.enumerated() {
            print (index, d.description, d.orderBook.description)
            if (index < 2) {
                XCTAssertTrue(d.existingOrders.count > 0)
            }
            else {
                XCTAssertTrue(d.existingOrders.count == 0)
            }
        }
    }

    func testCannotAddFromSameDeck() {
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
        guard let firstCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        firstDeck.notifySubscribers() // unlock the next deck
        let _ = firstPlayer.hand.add(firstCard)
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)

        // try adding another card from the same deck
        guard let anotherCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        // probably needs some sort of throw?
        XCTAssertTrue((firstPlayer.hand.find(card: anotherCard) != nil))

        firstPlayer.hand.add(anotherCard)
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        print (firstPlayer.hand.description)
    }**/

}
