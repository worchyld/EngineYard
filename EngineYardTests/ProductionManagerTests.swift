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
    
}
