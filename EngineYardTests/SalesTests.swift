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

        XCTAssertTrue(gameCopy.board == board)

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


        guard let copiedBoard = gameCopy.board else {
            XCTFail("No board copied")
            return
        }

        let salesObj = Selling.init(board: copiedBoard)
        salesObj.salesLoop()

        // expect the copied player:
        // first card production to be 0
        // first card spent production to be 10
        // sales book to record sales

        print (copiedPlayer.salesBook)



        /*
        if let copiedBoard = gameCopy.board {

            let salesObj = Selling.init(board: copiedBoard)
            salesObj.salesLoop()

            let copiedPlayerSB = copiedPlayer.salesBook

            XCTAssertTrue( copiedPlayerSB.sales.count == 3 , "\(copiedPlayerSB.sales.count)")
            XCTAssertTrue( copiedPlayerSB.totalUnitsSold == 10, "\(copiedPlayerSB.totalUnitsSold)")
        }
        else {
            XCTFail("No board was copied")
        }
        */
    }

}
