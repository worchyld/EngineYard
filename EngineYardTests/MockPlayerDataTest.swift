//
//  MockPlayerDataTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class MockPlayerDataTest: XCTestCase {

    func testMockGeneratedMinPlayers() {
        let players = MockData.players(howMany: Constants.Players.min)
        XCTAssertTrue(players?.count == Constants.Players.min)
    }

    func testMockGeneratedMaxPlayers() {
        let players = MockData.players(howMany: Constants.Players.max)
        XCTAssertTrue(players?.count == Constants.Players.max)
    }
}
