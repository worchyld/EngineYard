//
//  GameBoardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

fileprivate struct Mock {
    struct Cards {
        var green: Int = 0
        var red: Int = 0
        var blue: Int = 0
        var yellow: Int = 0
        var total : Int {
            return (self.green + self.red + self.blue + self.yellow)
        }

        struct Expected {
            static let green = Rules.Board.numberOfCardsForColor(engineColor: .green)
            static let red = Rules.Board.numberOfCardsForColor(engineColor: .red)
            static let blue = Rules.Board.numberOfCardsForColor(engineColor: .blue)
            static let yellow = Rules.Board.numberOfCardsForColor(engineColor: .yellow)
            static let total = Rules.Board.cards
        }
    }
}


class GameBoardTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGameBoardPrep() {
        let board = GameBoard()

        XCTAssert(board.decks.count == Rules.Board.decks, "Expected: \(Rules.Board.decks), Returned: \(board.decks.count)")

        for deck in board.decks {
            XCTAssert(deck.cards.count == deck.numberOfChildren, "Card count mismatch \(deck.cards.count) vs \(deck.numberOfChildren)")
        }

        for deck in board.decks {
            for card:Card in deck.cards {
                XCTAssertTrue(card.production.units == 0)
            }
        }
    }

    func testValidateDeckSetup() {
        let game = Game()
        guard let board = game.board else {
            XCTFail("No board created")
            return
        }

        // validate decks
        var mockCards = Mock.Cards()

        for deck in board.decks {
            XCTAssert(deck.cost % 4 == 0)
            XCTAssert(deck.productionCost == (deck.cost / 2))
            XCTAssert(deck.income == (deck.productionCost / 2))

            for _ in deck.cards {
                switch deck.color {
                case .green:
                    mockCards.green += 1
                    break
                case .red:
                    mockCards.red += 1
                    break
                case .yellow:
                    mockCards.yellow += 1
                    break
                case .blue:
                    mockCards.blue += 1
                    break
                }
            }
        } // next

        XCTAssert(mockCards.green == Mock.Cards.Expected.green, "Not enough green cards. Found: \(mockCards.green), Expected: \(Mock.Cards.Expected.green)")
        XCTAssert(mockCards.red == Mock.Cards.Expected.red, "Not enough red cards. Found: \(mockCards.red), Expected: \(Mock.Cards.Expected.red)")
        XCTAssert(mockCards.yellow == Mock.Cards.Expected.yellow, "Not enough yellow cards. Found: \(mockCards.yellow), Expected: \(Mock.Cards.Expected.yellow)")
        XCTAssert(mockCards.blue == Mock.Cards.Expected.blue, "Not enough blue cards. Found: \(mockCards.blue), Expected: \(Mock.Cards.Expected.blue)")
        XCTAssert(mockCards.total == Mock.Cards.Expected.total, "Not enough cards, total = \(mockCards.total), Expected: \(Mock.Cards.Expected.total)")

        // Expect that the first order to be generated
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 1)

        // Test inactive and active decks
        let inactiveDecks = board.decks.filter { (d:Deck) -> Bool in
            return !d.active
            }.count

        let activeDecks = board.decks.filter { (d:Deck) -> Bool in
            return d.active
            }.count

        XCTAssertTrue(inactiveDecks == 13)
        XCTAssertTrue(activeDecks == 1)
    }


    func testSubscriptionUnlocksNextDeck() {
        let game = Game()
        guard let board = game.board else {
            XCTFail("No board created")
            return
        }

        // Force unlock all decks after the first deck
        for d in board.decks {
            d.notifySubscribers()
        }

        // Test inactive and active decks
        let inactiveDecks = board.decks.filter { (d:Deck) -> Bool in
            return !d.active
            }.count

        let activeDecks = board.decks.filter { (d:Deck) -> Bool in
            return d.active
            }.count

        XCTAssertTrue(inactiveDecks == 0)
        XCTAssertTrue(activeDecks == Rules.Board.decks)
    }

}
