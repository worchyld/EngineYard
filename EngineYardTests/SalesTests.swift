//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SalesTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test on shadow copy
    func testSalesLoop() {
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

        // Copy the game state
        let gameCopy = game.copy() as! Game        

        guard let copiedPlayer = gameCopy.players?.first as? Player else {
            XCTFail("No copied player")
            return
        }

        XCTAssertTrue(copiedPlayer.hand.cards.count == player.hand.cards.count)

        guard let playerCard = player.hand.cards.first else {
            XCTFail("No cards in hand")
            return
        }

        // Reset the orderBook
        firstDeck.orderBook.clear()
        firstDeck.orderBook.add(.existingOrder, values: [3,5,2])
        playerCard.production.add(9)
        XCTAssertTrue(playerCard.production.units == 10)


        // Expect the original salesbook to stay the same
        let originalSB = player.salesBook
        let copiedSB = copiedPlayer.salesBook

        XCTAssertTrue(originalSB.sales.count == 0)
        XCTAssertTrue(copiedSB.sales.count == 0)

        let selling = Selling(game: gameCopy)
        selling.beginSelling()

        XCTAssertTrue(originalSB.sales.count == 0, "Actual: \(originalSB.sales.count)")
        XCTAssertTrue(copiedSB.sales.count == 1, "Actual: \(copiedSB.sales.count)")
    }

    func testSalesTurnOrder() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = game.players?[0] as? Player else {
            return
        }
        guard let secondPlayer = game.players?[1] as? Player else {
            return
        }
        guard let thirdPlayer = game.players?[2] as? Player else {
            return
        }
        guard let fourthPlayer = game.players?[3] as? Player else {
            return
        }
        guard let fifthPlayer = game.players?[4] as? Player else {
            return
        }

        let firstDeck = board.decks[0]
        let secondDeck = board.decks[1]

        let greenCard1 = firstDeck.cards[0]
        let greenCard2 = firstDeck.cards[1]

        let redCard1 = secondDeck.cards[0]
        let redCard2 = secondDeck.cards[1]

        do {
            try firstPlayer.hand.add(greenCard1)
        } catch let err {
            print (err)
        }

        do {
            try thirdPlayer.hand.add(greenCard2)
        } catch let err {
            print (err)
        }

        do {
            try secondPlayer.hand.add(redCard1)
        } catch let err {
            print (err)
        }

        do {
            try fourthPlayer.hand.add(redCard2)
        } catch let err {
            print (err)
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(secondPlayer.hand.cards.count == 1)
        XCTAssertTrue(thirdPlayer.hand.cards.count == 1)
        XCTAssertTrue(fourthPlayer.hand.cards.count == 1)
        XCTAssertTrue(fifthPlayer.hand.cards.count == 0)

        // Test sales turn order
        guard let firstDeckSalesTurnOrder = firstDeck.owners else {
            return
        }
        guard let secondDeckSalesTurnOrder = secondDeck.owners else {
            return
        }

        XCTAssertTrue(firstDeckSalesTurnOrder[0] == firstPlayer)
        XCTAssertTrue(firstDeckSalesTurnOrder[1] == thirdPlayer)

        XCTAssertTrue(secondDeckSalesTurnOrder[0] == secondPlayer)
        XCTAssertTrue(secondDeckSalesTurnOrder[1] == fourthPlayer)


    }

}
