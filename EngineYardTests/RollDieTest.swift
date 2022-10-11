//
//  RollDieTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/03/2022.
//

import XCTest
@testable import EngineYard

class RollDieTest: XCTestCase {
    func testDieRoll() throws {
        let d6 = Die.roll
        XCTAssertTrue(d6 > 0 && d6 < 7)
    }
}
