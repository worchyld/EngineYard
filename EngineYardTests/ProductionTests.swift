//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/05/2018.
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
        p.setInitialProduction()
        p.add(amount: 1)

        XCTAssertTrue(p.units == 2)
    }

    func testSpendProduction() {
        let p = Production()
        p.setInitialProduction()
        p.add(amount: 1)
        XCTAssertTrue(p.units == 2)

        p.spend(amount: 2)

        XCTAssertTrue(p.units == 0)
        XCTAssertTrue(p.spentUnits == 2)
    }

    func testResetProduction() {
        let p = Production()
        p.setInitialProduction()
        p.add(amount: 1)
        XCTAssertTrue(p.units == 2)

        p.spend(amount: 2)
        XCTAssertTrue(p.units == 0)
        XCTAssertTrue(p.spentUnits == 2)

        p.reset()
        XCTAssertTrue(p.units == 2)
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testComplexProductionSpend() {
        let p = Production()
        p.setInitialProduction()
        p.add(amount: 59)
        XCTAssertTrue(p.units == 60)

        p.spend(amount: 1)
        XCTAssertTrue(p.units == 59)
        XCTAssertTrue(p.spentUnits == 1)

        p.reset()
        XCTAssertTrue(p.units == 60)
        XCTAssertTrue(p.spentUnits == 0)
    }
    
}
