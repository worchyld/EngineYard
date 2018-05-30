//
//  GameSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/05/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameSetupTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThreePlayerSetup() {
        let game : Game = Game(players: Mock.players(howMany: 3))
        XCTAssertTrue(game.players.count == Rules.NumberOfPlayers.min)

        let _ = game.players.map({
            XCTAssert($0.wallet.balance == Rules.NumberOfPlayers.threePlayerSeedCash)
            XCTAssert($0.hand.cards.count == 1)

            guard let firstCard = $0.hand.cards.first else {
                XCTFail("First card does not exist for \($0.name), \($0.hand.description)")
                return
            }

            XCTAssertTrue(firstCard.parent?.generation == .first)
            XCTAssertTrue(firstCard.parent?.color == .green)
        })

        NSLog("[Card ownership]")
        NSLog("----------------\n")

        var index = 0
        for deck in game.board.decks {
            if (index == 0) {
                XCTAssertTrue(deck.owners?.count == 3)
            }

            // -----------------------

            for card in deck.cards {
                var parentName = "No parent"
                if let parentObj = card.parent {
                    parentName = parentObj.name
                }
                var cardOwnerName = "No owner"
                if let cardObj = card.owner {
                    cardOwnerName = cardObj.name
                }

                print ("\(parentName) owner >> \(cardOwnerName)")
            }

            index += 1
        }
    }

    
}
