//
//  SetupManagerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/05/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SetupManagerTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGameSetupManager() {

        let gsm = GameSetupManager()
        guard let game = gsm.setup(players: Mock.players(howMany: 3)) else {
            XCTFail("No game created")
            return
        }

        XCTAssertTrue(game.players.count == 3)


    }
    
}
