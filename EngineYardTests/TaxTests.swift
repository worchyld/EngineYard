//
//  TaxTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TaxTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTaxDue() {
        let balance = 100
        let due = Tax.due(onBalance: balance)
        XCTAssertTrue(due == 10)
    }

    func testPayTax() {
        var balance = 100
        balance = Tax.pay(onBalance: balance)
        XCTAssertTrue(balance == 100 - 10)
    }

    func testCalculateSalesTax() {
        let balance = 100
        let due = Tax.getSalesTax(onBalance: balance)
        XCTAssertTrue(due == 110)
    }

}
