//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddProduction() {
        let p = Production()
        p.add(amount: 1)
        XCTAssertTrue(p.units == 1, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testSpendProduction() {
        let p = Production()
        p.add(amount: 1)

        XCTAssertNoThrow(try p.spend(amount: 1))
        XCTAssertTrue(p.units == 0, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 1, "Units \(p.spentUnits)")

        p.reset()

        XCTAssertTrue(p.units == 1)
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testInvalidSpend() {
        let p = Production()
        p.add(amount: 1)

        XCTAssertThrowsError(try p.spend(amount: 3)) { error in
            XCTAssertEqual(error as? ProductionError, ProductionError.notEnoughUnits)
        }

        XCTAssertTrue(p.units == 1, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testComplexSpend() {
        let p = Production()

        // expect units = 2, spend = 0
        p.add(amount: 2)
        XCTAssertNoThrow(try p.spend(amount: 1))
        XCTAssertTrue(p.spentUnits == 1, "spent: \(p.spentUnits)")

        // expect units = 1, spend = 2
        p.add(amount: 1)
        XCTAssertNoThrow(try p.spend(amount: 1))
        XCTAssertTrue(p.units == 1, "\(p.units)")
        XCTAssertTrue(p.spentUnits == 2, "\(p.spentUnits)")

        // expect units = 3, spend = 0
        p.reset()
        XCTAssertTrue(p.units == 3)
        XCTAssertTrue(p.spentUnits == 0)
    }

}
