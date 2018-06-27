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


        var increment: Int = 0
        let _ = game.board.decks.map { (deck:Deck) in
            if (increment == 0) {
                XCTAssertTrue(deck.owners?.count == 3)
            }
            else {
                XCTAssertTrue(deck.owners?.count == 0)
            }

            increment += 1
        }

        var index = 0
        for deck in game.board.decks {
            if (index == 0) {
                XCTAssertTrue(deck.owners?.count == 3)
            }

            // -----------------------

            for card in deck.cards {
                print (card.description)
            }

            index += 1
        }
    }

    
}
