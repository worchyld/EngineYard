//
//  MockPlayerDataTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import Foundation

@testable import EngineYard

class MockPlayerDataTest: XCTestCase {

    func testValidPlayersShouldBeFalse() {
        let howManyPlayers = 1
        XCTAssertFalse(Player.isValidNumberOfPlayers(howManyPlayers))
    }

    func testMockGeneratedMinPlayers() {
        let howMany = Constants.Players.min
        let players = Player.generatePlayers(howMany: howMany)
        XCTAssertTrue(players?.count == howMany)
    }

    func testMockGeneratedMaxPlayers() {
        let howMany = Constants.Players.max
        let players = Player.generatePlayers(howMany: howMany)
        XCTAssertTrue(players?.count == howMany)
    }
}
