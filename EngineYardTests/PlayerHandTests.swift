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

    func testAddToPlayersHand() {
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

        let _ = firstPlayer.hand.add(firstCard)

        XCTAssertTrue(firstCard.owner == firstPlayer)
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.production.units == 1)
        XCTAssertTrue(firstCard.production.spentUnits == 0)

        let _ = firstDeck.cards.map({
            print ($0.description)
        })

        
    }

}
