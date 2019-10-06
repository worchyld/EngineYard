//
//  GameSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 04/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameSetupTests: EngineYardTests {

    var game: GameModel?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.game = GameModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func createPlayers(howMany: Int) -> [Player]? {
        guard Constants.Players.valid(howMany) else {
            return nil
        }
        var players: [Player] = [Player]()
        for index in stride(from:0, to: howMany, by: 1) {
            let player = Player(name: "Player #\(index)", isAI: true)
            players.append(player)
        }
        return players
    }

    func testThreePlayerGameSetup() {
        guard let _ = self.createPlayers(howMany: 3) else {
            XCTFail("No players created")
            return
        }
        
        guard let mockPlayers: [Player] = SetupManager.createPlayers(howMany: 3) else {
            XCTFail("Invalid player creation")
            return
        }
        XCTAssertTrue(mockPlayers.count == 3)
        guard let game = SetupManager.instance.setup(players: mockPlayers) else {
            XCTFail("no game")
            return
        }
        XCTAssertNotNil(game)
        XCTAssertNotNil(game.players)

        guard let players = game.players else {
            XCTFail("No players defined")
            return
        }

        XCTAssertTrue(players.count == 3)

        let _ = players.map({
            let p = ($0 as! Player)
            XCTAssertTrue(p.cash == Constants.threePlayerSeedCash)
        })

    }

}
