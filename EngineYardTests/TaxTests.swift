//
//  TaxTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 01/05/2023.
//

import XCTest

@testable import EngineYard

final class TaxTests: XCTestCase {

    func testTaxDue() throws {
        let amount = 100
        let expected = 10
        let sum = Tax.due(on: amount)
        
        XCTAssertEqual(sum, expected)
    }

    func testTaxPaid() throws {
        let amount = 100
        let due = 10
        let expected = (amount - due)
        let paid = Tax.pay(on: amount)
        
        XCTAssertEqual(paid, expected)
    }
    
    func testTaxDueOnValues() throws {
        let values = [9, 10, 100, 300]
        let expected = [0, 1, 10, 30]
        
        for i in 0..<values.count {
            let due = Tax.due(on: values[i])
            XCTAssertEqual(due, expected[i], "Array relation check failed for index \(i)")
        }
    }
}
