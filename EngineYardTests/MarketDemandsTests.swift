//
//  MarketDemandsTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 16/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Obsolescence and MarketDemands Tests
class MarketDemandsTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /*
    There are 4 cases of existing generations:
    (a) No generation exists:
        Nothing is done
    (b) 1 generation exists:
        If it doesn't have max dice, add 1x die and transfer all die from sales to orders
    (c) 2 generations exist:
        Remove 1x die from sales (or orders), mark as old
        Reroll all sales, transfer to orders
        Add 1x die to newer generation
    (d) 3 generations exist:
        Remove all die from oldest generation train, mark as obsolete
        Add 1x die to generation 2, transfer remaining die to orders
        Add 1x die to generation 3, transfer remaining die to orders
    */

    func testMaxDice() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }

        let activeGreenDecks = board.decks.filter { (d:Deck) -> Bool in
            return ((d.color == .green) && (d.active))
        }

        guard let firstDeck = activeGreenDecks.first else {
            XCTFail("No first deck found")
            return
        }

        XCTAssertTrue(activeGreenDecks.count == 1, "\(activeGreenDecks.count)")
        XCTAssertFalse(firstDeck.orderBook.hasMaximumDice)

        let emptySpaces = (firstDeck.capacity - firstDeck.existingOrders.count)
        for _ in 1...emptySpaces {
            firstDeck.orderBook.add(.existingOrder)
        }
        XCTAssertTrue(firstDeck.existingOrders.count == firstDeck.capacity)
        XCTAssertTrue(firstDeck.orderBook.hasMaximumDice)
    }

    func testNoGenerations() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        guard let redDecks = Board.findActiveGenerations(in: board.decks, color: .red) else {
            XCTFail("No decks found")
            return
        }
        XCTAssertTrue(redDecks.count == 0)
    }

    func testOneGeneration() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        guard let greenDecks = Board.findActiveGenerations(in: board.decks, color: .green) else {
            XCTFail("No decks found")
            return
        }
        XCTAssertTrue(greenDecks.count == 1)
    }

    func testTwoGenerations() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        let greenDecks = board.decks.filter { (d:Deck) -> Bool in
            return (d.color == .green)
        }
        XCTAssertTrue(greenDecks.count == 5)

        let firstTwoGens = greenDecks[0...1]
        for d:Deck in firstTwoGens {
            d.orderBook.add(.existingOrder)
        }
        guard let results = Board.findActiveGenerations(in: board.decks, color: .green) else {
            XCTFail("No decks found")
            return
        }
        XCTAssertTrue(results.count == 2)
    }


    func testThreeGenerationsExist() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        let greenDecks = board.decks.filter { (d:Deck) -> Bool in
            return (d.color == .green)
        }
        XCTAssertTrue(greenDecks.count == 5)

        let firstTwoGens = greenDecks[0...2]
        for d:Deck in firstTwoGens {
            d.orderBook.add(.existingOrder)
        }
        guard let results = Board.findActiveGenerations(in: board.decks, color: .green) else {
            XCTFail("No decks found")
            return
        }
        XCTAssertTrue(results.count == 3)
    }

    func testBasicTransfer() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        guard let firstDeck = board.decks.first else {
            return
        }
        XCTAssertTrue(firstDeck.existingOrders.count == 1)

        guard let firstExistingOrder = firstDeck.orderBook.existingOrders.first else {
            XCTFail("No first order found")
            return
        }

        // Move an `existingOrder` -> `completed`
        firstDeck.orderBook.transfer(order: firstExistingOrder)

        guard let firstCompletedOrder = firstDeck.orderBook.completedOrders.first else {
            XCTFail("No completed orders")
            return
        }

        XCTAssertTrue(firstExistingOrder.value == firstCompletedOrder.value)
        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.count == 0)
        XCTAssertTrue(firstDeck.orderBook.completedOrderValues.count == 1)

        // Move a `completedOrder` -> `existing`
        firstDeck.orderBook.transfer(order: firstCompletedOrder)
        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.count == 1)
        XCTAssertTrue(firstDeck.orderBook.completedOrderValues.count == 0)
    }

    func testRerollAndTransfer() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        guard let firstDeck = board.decks.first else {
            return
        }
        XCTAssertTrue(firstDeck.existingOrders.count == 1)

        guard let firstExistingOrder = firstDeck.orderBook.existingOrders.first else {
            XCTFail("No first order found")
            return
        }

        // Move an `existingOrder` -> `completed`
        firstDeck.orderBook.transfer(order: firstExistingOrder)

        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.count == 0)
        XCTAssertTrue(firstDeck.orderBook.completedOrderValues.count == 1)

        // Reroll and Transfer
        firstDeck.orderBook.rerollAndTransferCompletedOrders()

        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.count == 1)
        XCTAssertTrue(firstDeck.orderBook.completedOrderValues.count == 0)
    }

    func testOneGens() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        let greenDecks = board.decks.filter { (d:Deck) -> Bool in
            return (d.color == .green)
        }
        guard let firstDeck = greenDecks.first else {
            print ("No first deck found")
            return
        }
        let ob = MarketDemandsManager.init(decks: board.decks)
        let gens = ob.getGenerations(for: .green)
        XCTAssertTrue(gens?.count == 1)
        ob.handleGenerations(for: .green)

        XCTAssertTrue(firstDeck.orderBook.completedOrders.count == 0)
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count == 2)
    }

    func testTwoGens() {
        guard let board = self.prepare() else {
            XCTFail("Board object did not initialise")
            return
        }
        let greenDecks = board.decks.filter { (d:Deck) -> Bool in
            return (d.color == .green)
        }
        let firstTwoGens = greenDecks[0...1]
        for item in firstTwoGens {
            item.orderBook.add(.existingOrder)
        }
        let ob = MarketDemandsManager.init(decks: board.decks)
        let gens = ob.getGenerations(for: .green)
        XCTAssertTrue(gens?.count == 2)

        ob.handleGenerations(for: .green)

        for (index, deck) in firstTwoGens.enumerated() {
            if (index == 0) {
                XCTAssertTrue(deck.rustedState == .old)
            }
            else {
            }
        }
    }
}
