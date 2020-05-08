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

    func testTaxDue() {
        let balance: Int = 100
        let taxDue = Tax.due(on: balance)
        XCTAssertTrue(taxDue == 10)
    }

    func testPayTax() {
        var balance = 100
        balance = Tax.pay(on: balance)
        XCTAssertTrue(balance == 100 - 10)
    }

    func testAddTax() {
        let balance = 100
        let taxDue = Tax.add(on: balance)
        XCTAssertTrue(taxDue == 110)
    }
}
