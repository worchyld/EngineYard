//
//  D6Tests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import XCTest
@testable import EngineYard

final class D6Tests: XCTestCase {

    func testD6Roll() {
        let value = D6.roll
        XCTAssertTrue(value >= D6.minimumValue)
        XCTAssertTrue(value <= D6.maximumValue)
    }
    
    func testCanIncrementD6() {
        let value = 1
        let expected = 2
        let newValue = D6.increment(value: value, by: 1)
        XCTAssertEqual(newValue, expected)
    }

    func testCannotIncrementPastSix() {
        let value = 6
        let expected = 6
        let newValue = D6.increment(value: value, by: 1)
        XCTAssertEqual(newValue, expected)
    }
    
}
