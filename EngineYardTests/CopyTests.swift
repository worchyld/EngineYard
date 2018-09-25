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

    var game: Game!
    var board: Board!

    override func setUp() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        self.game = game
        self.board = board
    }

    override func tearDown() {
        self.board = nil
    }

    func testCopyBoard() {
        let copied = board.copy() as! Board

        XCTAssertTrue(board.decks.count == Rules.Board.decks)

        guard let originalDeck = board.decks.first else {
            return
        }

        guard let firstDeck = copied.decks.first else {
            return
        }
        firstDeck.orderBook.clear()

        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 0)
        XCTAssertTrue(firstDeck.orderBook.completedOrders.count == 0)
        XCTAssertTrue(originalDeck.orderBook.existingOrders.count == 1)
        XCTAssertTrue(originalDeck.orderBook.completedOrders.count == 0)
    }

    func testCopyPlayersHand() {
        guard let firstDeck = board.decks.first else {
            return
        }
        guard let firstPlayer = game.players?.first as? Player else {
            return
        }
        guard let card = firstDeck.findFirstUnownedCard() else {
            return
        }

        XCTAssertNoThrow(try firstPlayer.hand.add(card))

        let copiedPlayer = firstPlayer.copy() as! Player

        copiedPlayer.hand.empty()

        XCTAssertTrue(copiedPlayer.hand.cards.count == 0, "\(copiedPlayer.hand.cards.count)")
        XCTAssertTrue(firstPlayer.hand.cards.count == 1, "\(firstPlayer.hand.cards.count)")
    }

    func testCopyWallet() {
        guard let firstPlayer = game.players?.first as? Player else {
            return
        }
        let originalCash: Int = firstPlayer.cash

        let copiedPlayer = firstPlayer.copy() as! Player

        XCTAssertNoThrow(try copiedPlayer.wallet.debit(amount: copiedPlayer.cash))
        XCTAssertNoThrow(try copiedPlayer.wallet.credit(amount: 100))
        XCTAssertTrue(copiedPlayer.wallet.balance == 100, "\(copiedPlayer.cash)")
        XCTAssertTrue(firstPlayer.wallet.balance == originalCash, "\(firstPlayer.cash)")
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

        XCTAssertTrue( d1.orderBook.existingOrderValues == d2.orderBook.existingOrderValues , "\(d1.orderBook.existingOrderValues), \(d2.orderBook.existingOrderValues), \(d2.orderBook.description)")

        guard let d2Order = d2.orderBook.existingOrders.first else {
            XCTFail("No order found")
            return
        }

        d2Order.value -= 3

        XCTAssertTrue(d1.orderBook.existingOrderValues == [3,5,2], "\(d1.orderBook.existingOrderValues)")
        XCTAssertTrue(d2.orderBook.existingOrderValues == [0,5,2], "\(d2.orderBook.existingOrderValues)")

        print ("d1: \(d1.orderBook.existingOrderValues)")
        print ("d2: \(d2.orderBook.existingOrderValues)")
    }
}
