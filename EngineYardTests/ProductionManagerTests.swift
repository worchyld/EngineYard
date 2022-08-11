//
//  ProductionManagerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/04/2022.
//

import XCTest
@testable import EngineYard

class ProductionManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductionUnitsAdd() throws {
        let units = 1
        let spent = 0
        
        let pm = ProductionManager(units: units)
        XCTAssertEqual(pm.units, units)
        XCTAssertEqual(pm.spent, spent)
    }
    

    func testProductionUnitsDidSpend() throws {
        let unitsBefore = 2
        let unitsAfter = 1
        
        let pm = ProductionManager(units: unitsBefore)
        XCTAssertEqual(pm.units, unitsBefore)
        XCTAssertEqual(pm.spent, 0)
        
        try pm.spend(1)
        XCTAssertEqual(pm.units, unitsAfter)
        XCTAssertEqual(pm.spent, 1)
    }
    
    func testDidUpdateProductionUnits() throws {
        var units = 1
        
        let pm = ProductionManager(units: units)
        try pm.add(1)
        units = pm.units
        
        XCTAssertTrue(units == 2)
    }
    
    func testDidSpendAndResetUnits() throws {
        let startingUnits = 5
        var units = startingUnits
        let spend = 2
        let expected = (units - spend)
     
        // spend 2 units
        let pm = ProductionManager(units: units)
        XCTAssertTrue(pm.units == units)
        XCTAssertTrue(pm.spent == 0)
        
        try pm.spend(spend)
        XCTAssertTrue(pm.units == expected)
        XCTAssertTrue(pm.spent == spend)
                
        units = pm.units
        XCTAssertTrue(units == expected) // expect units = 3
        XCTAssertTrue(pm.spent == 2) // expect spent = 2
        
        // reset
        pm.reset()
        units = pm.units
        
        XCTAssertTrue(units == startingUnits, "units: \(units)")
    }
}
