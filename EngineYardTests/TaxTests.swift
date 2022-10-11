//
//  TaxTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 04/03/2022.
//

import XCTest

@testable import EngineYard

class TaxTests: XCTestCase {
    func testTaxDue() {
        let balance = 100
        let expected = 10
        let taxDue = Tax.calculate(on: balance)
        XCTAssertTrue(taxDue == expected)
    }
    
    func testPayTax() {
        var balance = 100
        let expected = 90
        balance = Tax.pay(on: balance)
        XCTAssertTrue(balance == expected)
    }
    
    func testNegativeValues() {
        let balance = -10
        let expected = 0
        let taxDue = Tax.calculate(on: balance)
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
            let taxDue = Tax.calculate(on: value)

            XCTAssertTrue(taxDue == expected)
        }
    }

}
