//
//  GameSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 27/10/2022.
//

import XCTest
@testable import EngineYard

final class GameSetupTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetupForThreePlayers() {
        let players = [Player(), Player(), Player()]
        var game = Game()
        let gsm = GameSetupManager(game: game)
        do {
            game = try gsm.setup(for: players)
            
            guard let hasPlayers = game.players else {
                XCTAssertThrowsError("No players defined")
                return
            }
            
            XCTAssertTrue(hasPlayers.count == 3, "Got \(hasPlayers.count)")
            
            for p in players {
                XCTAssertTrue(p.hand.count == 1)
                guard let firstCard = p.hand.first else {
                    XCTAssertThrowsError("No card found")
                    return
                }
                guard let firstLoco = firstCard.loco else {
                    XCTAssertThrowsError("No loco found")
                    return
                }
                
                XCTAssertTrue(firstLoco.livery == .green)
                XCTAssertTrue(firstLoco.generation == .first)
                XCTAssertTrue(firstCard.production.units == 1)
                XCTAssertTrue(firstCard.production.spent == 0)
            }
            
            
            
        } catch let err  {
            XCTAssertNoThrow(err)
        }
    }

}
