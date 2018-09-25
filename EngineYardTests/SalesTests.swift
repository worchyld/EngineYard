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

        // COPY THE BOARD FIRST!!
        let copyBoard = board.copy() as! Board

        let decks: [Deck] = Board.filterDecksWithExistingOrders(decks: copyBoard.decks)

        for deck in decks {
            for card in deck.cards {

                do {
                    let unitsSold = card.production.units
                    try card.production.spend(unitsSold)
                    deck.orderBook.reduceValueAt(index: 0, byValue: unitsSold)
                } catch let err {
                    print (err.localizedDescription)
                }
            }
        }

    }

}
