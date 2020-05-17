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

    func testValidNumberOfPlayersShouldBeFalse() {
        let howManyPlayers = 1
        XCTAssertFalse(Constants.ValidNumberOfPlayers.isValid(howManyPlayers))
    }

    func testMinValidNumberOfPlayersShouldBeTrue() {
        let howManyPlayers = Constants.ValidNumberOfPlayers.min
        XCTAssertTrue(Constants.ValidNumberOfPlayers.isValid(howManyPlayers))
    }

    func testMaxValidNumberOfPlayersShouldBeTrue() {
        let howManyPlayers = Constants.ValidNumberOfPlayers.max
        XCTAssertTrue(Constants.ValidNumberOfPlayers.isValid(howManyPlayers))
    }

    func testMockGeneratedMinPlayers() {
        let howMany = Constants.ValidNumberOfPlayers.min
        let players = Player.generatePlayers(howMany: howMany)
        XCTAssertTrue(players?.count == howMany)
    }

    func testMockGeneratedMaxPlayers() {
        let howMany = Constants.ValidNumberOfPlayers.max
        let players = Player.generatePlayers(howMany: howMany)
        XCTAssertTrue(players?.count == howMany)
    }
}
