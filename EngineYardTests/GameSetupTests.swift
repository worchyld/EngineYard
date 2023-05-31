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
    
    func testBoardPreparation() throws {
        let dummyPlayers = [Player(), Player(), Player()]
        let gsm = GameSetupManager()
        do {
            let _ = try gsm.setup(for: dummyPlayers)
        } catch let err {
            throw err
        }
    }

}
