//
//  TaxTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TaxTests: XCTestCase {

    func testTaxDue() {
        let balance: Int = 100
        let expected: Int = 10
        let taxDue = Tax.due(on: balance)
        XCTAssertTrue(taxDue == expected)
    }

    func testPayTax() {
        var balance = 100
        let expected = 90
        balance = Tax.pay(on: balance)
        XCTAssertTrue(balance == expected)
    }

    func testAddTax() {
        let balance = 100
        let expected = 110
        let taxDue = Tax.add(on: balance)
        XCTAssertTrue(taxDue == expected)
    }

    func testTaxNegativeValue() {
        let balance = -10
        let expected = 0
        let taxDue = Tax.due(on: balance)
        XCTAssertTrue(taxDue == expected)

        let taxPay = Tax.pay(on: balance)
        XCTAssertTrue(taxPay == expected)

        let taxAdd = Tax.add(on: balance)
        XCTAssertTrue(taxAdd == expected)
    }

    func testTaxDueOnArrayOfValues() {
        let arrayOfValues = [["value": 300, "expected": 30],
                             ["value": 21, "expected": 2],
                             ["value": 14, "expected": 1],
                             ["value": 7, "expected": 0],
                             ["value": 0, "expected":0],
                             ["value": -1, "expected":0]]

        let _ = arrayOfValues.map{
            let value = $0["value"]! as Int
            let expected = $0["expected"]! as Int
            let taxDue = Tax.due(on: value)

            XCTAssertTrue(taxDue == expected)
        }
    }

}
