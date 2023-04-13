//
//  IntTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import XCTest
@testable import EngineYard

final class IntTests: XCTestCase {

    func testOneIsFirstOrdinalFormat() {
        let number = 1
        let expected = "1st"
        let result = number.ordinalFormat
        XCTAssertEqual(result, expected)
    }
    

}
