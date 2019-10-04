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
        do {
            let _ = try Constants.NumberOfPlayers.valid(howMany)
        } catch {
            print (error)
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

        //self.game.setup(with: players)
    }

}
