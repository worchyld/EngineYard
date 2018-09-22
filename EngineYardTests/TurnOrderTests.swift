//
//  TurnOrderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TurnOrderTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShuffle() {
        var numbers = [1,2,3,4,5]
        numbers.shuffle()
        print (numbers)
    }

    func testShuffled() {
        let numbers = [1,2,3,4,5]
        let result = numbers.shuffled()
        print (result)
    }

    func testShufflePlayers() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }

        game.shuffleTurnOrder()
        print (game.players!)
    }

    func testTurnOrderDidChange() {
        guard let game:Game = Game.setup(with: Mock.players(howMany: 5)) else {
            XCTFail("Game object did not initialise")
            return
        }

        game.shuffleTurnOrder()
        game.activePlayer = game.players?.first
        game.nextOnTurn()

        guard let activePlayer = game.activePlayer else {
            XCTFail("No active player")
            return
        }
        guard let players = game.players else {
            XCTFail("No players")
            return
        }

        XCTAssertTrue(game.turnOrderIndex == 1)
        XCTAssertTrue(activePlayer.playerId == players[game.turnOrderIndex].playerId)
    }

    func testTurnOrderDidWrapAround() {
        guard let game:Game = Game.setup(with: Mock.players(howMany: 5)) else {
            XCTFail("Game object did not initialise")
            return
        }

        game.shuffleTurnOrder()
        game.activePlayer = game.players?.first

        guard let players = game.players else {
            XCTFail("No players")
            return
        }
        guard let activePlayer = game.activePlayer else {
            XCTFail("No active player")
            return
        }

        let _ = players.map { _ in  
            game.nextOnTurn()
        }

        XCTAssertTrue(game.turnOrderIndex == 0, "\(game.turnOrderIndex)")
        XCTAssertTrue(activePlayer.playerId == players[game.turnOrderIndex].playerId, "\(activePlayer.playerId)")
    }
}
