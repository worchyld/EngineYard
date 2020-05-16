//
//  BasicGKGameModelTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import GameplayKit

@testable import EngineYard

class BasicGKGameModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDidCreateGameModel() -> GameModel {
        let gameModel = GameModel.init()
        XCTAssertNotNil(gameModel)
        return gameModel
    }

    func testGameModelHasThreePlayers() -> GameModel {
        let players = [ Player.init(), Player.init(),Player.init() ]
        let gameModel = self.testDidCreateGameModel()
        gameModel.players = players
        XCTAssertTrue(players.count == 3)
        let _ = players.map({
            XCTAssertTrue($0.conforms(to: GKGameModelPlayer.self))
        })
        return gameModel
    }

    func testGameModelHasNoActivePlayer() {
        let gameModel = self.testDidCreateGameModel()
        XCTAssertNil(gameModel.activePlayer)
    }

    func testGameModelHasActivePlayer() {
        let gameModel = self.testGameModelHasThreePlayers()
        gameModel.activePlayer = gameModel.players?.first
        XCTAssertNotNil(gameModel.activePlayer)
    }

}
