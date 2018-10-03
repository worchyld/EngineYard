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

    func testCopyGame() {
        let gameCopy = game.copy() as! Game


        guard let players = game.players else {
            XCTFail("No players")
            return
        }
        guard let _ = gameCopy.players else {
            XCTFail("No copied players")
            return
        }

        XCTAssertTrue(gameCopy.players!.count == players.count)

        guard let copiedPlayer = gameCopy.players?.first as? Player else {
            print ("No copied player found")
            return
        }

        guard let player = game.players?.first as? Player else {
            return
        }

        let expectedCash = player.cash

        XCTAssertNoThrow(try copiedPlayer.wallet.debit(amount: copiedPlayer.cash))
        XCTAssertNoThrow(try copiedPlayer.wallet.credit(amount: 100))

        XCTAssertTrue(player.cash == expectedCash , "Expected: \(expectedCash). Actual: \(player.cash)")
        XCTAssertTrue(copiedPlayer.cash == 100)
    }

    func testCopyBoard() {
        XCTAssertTrue(game.board.decks.count == Rules.Board.decks)
        let gameCopy = game.copy() as! Game

        XCTAssertTrue(gameCopy.board.decks.count == Rules.Board.decks)
        XCTAssertTrue(board.decks.count == Rules.Board.decks)


        // reset the orders of the copied object
        guard let copiedFirstDeck = gameCopy.board.decks.first else {
            return
        }
        guard let originalDeck = game.board.decks.first else {
            return
        }

        copiedFirstDeck.orderBook.clear()

        // expect the copied orderbook to be empty
        // expect the original orderbook to have 1 order

        XCTAssertTrue(copiedFirstDeck.orderBook.existingOrders.count == 0)
        XCTAssertTrue(originalDeck.orderBook.existingOrders.count == 1)
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

    func testCopyAndSpendProduction() {
        guard let firstPlayer = game.players?.first as? Player else {
            return
        }
        guard let firstDeck = board.decks.first else {
            return
        }
        guard let card = firstDeck.findFirstUnownedCard() else {
            return
        }
        XCTAssertNoThrow(try firstPlayer.hand.add(card))
        XCTAssertTrue(card.production.units == 1)

        let copiedPlayer = firstPlayer.copy() as! Player
        guard let copiedCard = copiedPlayer.hand.cards.first else {
            return
        }
        let units = copiedCard.production.units
        XCTAssertTrue(units == 1)
        XCTAssertNoThrow(try copiedCard.production.spend(units))

        XCTAssertTrue(card.production.units == 1)
        XCTAssertTrue(copiedCard.production.units == 0)

        let totalUnits = copiedPlayer.hand.cards.reduce(0, { $0 + $1.production.units } )
        XCTAssertTrue(totalUnits == 0)
    }

    func testDuplicateHand() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        guard let player = game.players?.first as? Player else {
            print ("No player found")
            return
        }
        guard let unownedCard = firstDeck.findFirstUnownedCard() else {
            return
        }
        XCTAssertNoThrow(try player.hand.add(unownedCard))
        XCTAssertTrue(player.hand.cards.count == 1)


        let gameCopy = game.copy() as! Game

        guard let copiedPlayer = gameCopy.players?.first as? Player else {
            XCTFail("No copied player")
            return
        }

        let expected = player.hand.cards.count

        XCTAssertTrue(copiedPlayer.hand.cards.count == expected)
        XCTAssertTrue(player.hand.cards.count == expected)

        copiedPlayer.hand.empty()

        XCTAssertTrue(copiedPlayer.hand.cards.count == 0)
        XCTAssertTrue(player.hand.cards.count == expected)
    }

    func testCopiedProduction() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        guard let player = game.players?.first as? Player else {
            print ("No player found")
            return
        }
        guard let unownedCard = firstDeck.findFirstUnownedCard() else {
            return
        }
        XCTAssertNoThrow(try player.hand.add(unownedCard))
        XCTAssertTrue(player.hand.cards.count == 1)

        let gameCopy = game.copy() as! Game

        guard let originalFirstCard = player.hand.cards.first else {
            XCTFail("No hand")
            return
        }

        guard let copiedPlayer = gameCopy.players?.first as? Player else {
            XCTFail("No copied player")
            return
        }

        guard let copiedCard = copiedPlayer.hand.cards.first else {
            XCTFail("No copied hand")
            return
        }

        let expected = originalFirstCard.production.units
        XCTAssertTrue(copiedCard.production.units == expected)

        XCTAssertNoThrow(try copiedCard.production.spend(expected))
        XCTAssertTrue(copiedCard.production.units == 0)
        XCTAssertTrue(originalFirstCard.production.units == expected)
    }

    func testCopiedSalesBook() {
        guard let firstPlayer = game.players?.first as? Player else {
            return
        }

        XCTAssertTrue(firstPlayer.salesBook.sales.count == 0)

        let gameCopy = game.copy() as! Game

        guard let copiedPlayer = gameCopy.players?.first as? Player else {
            XCTFail("copied player")
            return
        }

        let mockSale = Sale.init(units: 10, price: 10)
        copiedPlayer.salesBook.add(sale: mockSale)

        XCTAssertNotNil(copiedPlayer.salesBook.owner)

        XCTAssertTrue(copiedPlayer.salesBook.sales.count == 1)
        XCTAssertTrue(firstPlayer.salesBook.sales.count == 0)
        XCTAssertTrue(firstPlayer.salesBook.totalUnitsSold == 0)
        XCTAssertTrue(firstPlayer.salesBook.totalDollarValue == 0)

        XCTAssertTrue(copiedPlayer.salesBook.totalUnitsSold == 10, "\(copiedPlayer.salesBook.totalUnitsSold)")
        XCTAssertTrue(copiedPlayer.salesBook.totalDollarValue == 100)

    }

    func testMockSale() {

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
