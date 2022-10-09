//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/10/2022.
//

import XCTest

@testable import EngineYard

final class ProductionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testInitialUnits() throws {
        let p = Production(units: 1, spent: 0)
        XCTAssertTrue(p.units == 1)
        XCTAssertTrue(p.spent == 0)
    }
    
    func testAddUnits() throws {
        var p = Production(units: 1, spent: 0)
        p = p.execute(.addProductionUnits(1))
        XCTAssertTrue(p.units == 2)
        XCTAssertTrue(p.spent == 0)
    }
    
    func testSpendUnits() throws {
        var p = Production(units: 5, spent: 0)
        p = p.execute(.spendProductionUnits(1))
        XCTAssertTrue(p.units == 4)
        XCTAssertTrue(p.spent == 1)
    }
    
    func testSpendUnitsMultipleTimes() throws {
        var p = Production(units: 5, spent: 0)
        p = p.execute(.spendProductionUnits(1))
        p = p.execute(.spendProductionUnits(1))
        p = p.execute(.spendProductionUnits(1))
        p = p.execute(.spendProductionUnits(1))
        XCTAssertTrue(p.units == 1)
        XCTAssertTrue(p.spent == 4, "expected 4, got: \(p.spent)")
    }
    
    func testResetUnits() throws {
        var p = Production(units: 4, spent: 0)
        p = p.execute(.spendProductionUnits(3))
        XCTAssertTrue(p.units == 1)
        XCTAssertTrue(p.spent == 3)
        p = p.execute(.resetProductionUnits)
        XCTAssertTrue(p.units == 4)
        XCTAssertTrue(p.spent == 0)
    }
}
