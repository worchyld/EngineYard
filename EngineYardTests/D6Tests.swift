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
    
    func testCanIncrement() {
        let value0 = D6.increment(value: 1, by: 1)
        XCTAssertEqual(value0, 2)
        
        let value1 = D6.increment(value: 1, by: 2)
        XCTAssertEqual(value1, 3)
        
        let value2 = D6.increment(value: 1, by: 3)
        XCTAssertEqual(value2, 4)
        
        let value3 = D6.increment(value: 1, by: 4)
        XCTAssertEqual(value3, 5)
        
        let value4 = D6.increment(value: 1, by: 5)
        XCTAssertEqual(value4, 6)
    }

    func testCannotIncrementPastSix() {
        let value = 6
        let expected = 6
        let newValue = D6.increment(value: value, by: 1)
        XCTAssertEqual(newValue, expected)
    }
    
    func testDecrement() {
        let value0 = D6.decrement(value: 6, by: 1)
        XCTAssertEqual(value0, 5)
        
        let value1 = D6.decrement(value: 6, by: 2)
        XCTAssertEqual(value1, 4)
        
        let value2 = D6.decrement(value: 6, by: 3)
        XCTAssertEqual(value2, 3)
        
        let value3 = D6.decrement(value: 6, by: 4)
        XCTAssertEqual(value3, 2)
        
        let value4 = D6.decrement(value: 6, by: 5)
        XCTAssertEqual(value4, 1)
    }
    
    func testCannotDecrementBelowOne() {
        let value = 1
        let expected = 1
        let newValue = D6.decrement(value: value, by: 1)
        XCTAssertEqual(newValue, expected)
    }
    
}
