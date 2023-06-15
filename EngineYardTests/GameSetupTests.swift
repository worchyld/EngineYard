//
//  GameSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 31/05/2023.
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
    
    func testPrepareBoard() throws {
        let gsm = GameSetupManager()
        let board = gsm.prepareBoard()
        
        XCTAssertTrue(board.spaces.count == 14)
    }
    
    func testInvalidPlayerCount() throws {
        let dummyPlayers = [Player()]
        
        let gsm = GameSetupManager()
        
        XCTAssertThrowsError(try gsm.setup(for: dummyPlayers)) { error in
            XCTAssertEqual(error as! GameErrorDelegate, GameErrorDelegate.invalidPlayerCount)
        }
    }

    func testThreePlayerSetup() throws {
        let dummyPlayers = [Player(), Player(), Player()]
        let gsm = GameSetupManager()
        do {
            let game = try gsm.setup(for: dummyPlayers)
            
            XCTAssertTrue(game.players.count == 3, "Players - \(game.players.count)")
            
            for p in game.players {
                XCTAssertTrue(p.cash == 12)
            }

            
        } catch let err {
            throw err
        }
    }
    
    func testFourPlayerSetup() throws {
        let dummyPlayers = [Player(), Player(), Player(), Player()]
        let gsm = GameSetupManager()
        do {
            let game = try gsm.setup(for: dummyPlayers)
            
            XCTAssertTrue(game.players.count == 4)
            
            for p in game.players {
                XCTAssertTrue(p.cash == 12)
            }
            
        } catch let err {
            throw err
        }
    }
    
    func testFivePlayerSetup() throws {
        let dummyPlayers = [Player(), Player(), Player(), Player(), Player()]
        let gsm = GameSetupManager()
        do {
            let game = try gsm.setup(for: dummyPlayers)
            
            XCTAssertTrue(game.players.count == 5)
            
            for p in game.players {
                XCTAssertTrue(p.cash == 14)
            }

            
        } catch let err {
            throw err
        }
    }
}
