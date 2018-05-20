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

    func threePlayerGameSetupTests() {
        let game : Game = Game(players: Mock.players(howMany: 3))
        XCTAssertTrue(game.players.count == Rules.NumberOfPlayers.min)

        let _ = game.players.map({
            XCTAssert($0.wallet.balance == Rules.NumberOfPlayers.threePlayerSeedCash)
            //XCTAssert($0.hand.cards.count == 1)
        })

        /*
        for deck: Deck in game.board.decks {
            for card: Card in deck.cards {
                XCTAssertNil(card.owner)
            }
        }
        */
    }

    
}
