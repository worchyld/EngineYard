//
//  DieTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 14/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class DieTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDieRoll() {
        let result = Die.roll()
        XCTAssertTrue(result > 0 && result < 7)
    }

    func testMultipleRolls() {
        var results: [Int] = [Int]()
        for _ in 1...7 {
            results.append( Die.roll() )
        }
        print (results)
    }
    
}
