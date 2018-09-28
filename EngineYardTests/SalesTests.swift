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
        guard let playerCard = player.hand.cards.first else {
            XCTFail("No cards in hand")
            return
        }


        firstDeck.orderBook.clear()
        firstDeck.orderBook.add(.existingOrder, values: [3,5,2])
        playerCard.production.add(9)
        XCTAssertTrue(playerCard.production.units == 10)

        let gameCopy = game.copy() as! Game

        



        if let copiedBoard = gameCopy.board {

            guard let copiedPlayer = gameCopy.players?.first as? Player else {
                XCTFail("No copied player -- \(String(describing: gameCopy.players?.description))")
                return
            }

            let salesObj = Selling.init(board: copiedBoard)
            salesObj.salesLoop()

            // Test dollar value sales
            let expected = ((3 + 5 + 2) * firstDeck.income)

            XCTAssertTrue(copiedPlayer.salesBook.sales.count == 3 , "\(player.salesBook.sales.count)")
            XCTAssertTrue(copiedPlayer.salesBook.totalUnitsSold == 10, "\(player.salesBook.totalUnitsSold)")
            XCTAssertTrue(copiedPlayer.salesBook.totalDollarValue == expected, "\(player.salesBook.totalDollarValue)")

            XCTAssertTrue(player.salesBook.sales.count == 0, "\(player.salesBook.sales.count)")
            XCTAssertTrue(player.salesBook.totalUnitsSold == 0, "\(player.salesBook.totalUnitsSold)")
            XCTAssertTrue(player.salesBook.totalDollarValue == 0, "\(player.salesBook.totalDollarValue)")

        }
        else {
            XCTFail("No copied board")
            return
        }



    }

}
