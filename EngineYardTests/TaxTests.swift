//
//  TaxTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TaxTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPayTax() {
        let balace = 100
        let expected = 90
        let sum = Tax.pay(onBalance: balace)
        XCTAssertTrue(sum == expected, "\(sum). Expected: \(expected)")
    }

    func testTaxDue() {
        XCTAssertTrue(Tax.due(onBalance: 9) == 0)
        XCTAssertTrue(Tax.due(onBalance: 10) == 1)
        XCTAssertTrue(Tax.due(onBalance: 14) == 1)
        XCTAssertTrue(Tax.due(onBalance: 20) == 2)
    }

    func testAddTax() {
        let balance = 300
        let expected = 330
        let sum = Tax.add(toBalance: balance)
        XCTAssertTrue(sum == expected, "\(sum). Expected: \(expected)")
    }
}
