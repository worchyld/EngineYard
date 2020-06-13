//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testProductionUnitsEquals1() {
        var production = Production()
        XCTAssertTrue(production.units == 0)
        XCTAssertTrue(production.spentUnits == 0)

        production.add(1)
        XCTAssertTrue(production.units == 1)
        XCTAssertTrue(production.spentUnits == 0)
    }

    func testProductionSpending2UnitsThrows() {
        var production = Production()
        production.add(1)

        XCTAssertThrowsError(try production.spend(2)) { error in
           XCTAssertEqual(error as! ProductionError, ProductionError.resultWillBeNegative(value: 2))
        }
    }

    func testProductionCanSpend1Unit() {
        var production = Production()
        production.add(2)

        XCTAssertNoThrow(try production.canSpend(1))
    }

    func testProductionDidSpend1Unit() {
        var production = Production()
        production.add(2)

        XCTAssertNoThrow(try production.canSpend(1))
        production.decreaseProduction(by: 1)

        XCTAssertTrue(production.units == 1)
        XCTAssertTrue(production.spentUnits == 1, "Spent: \(production.spentUnits)")
    }

    func testProductionDidSpend7Units() {
         var production = Production()
         production.add(10)

         XCTAssertNoThrow(try production.canSpend(7))
         production.decreaseProduction(by: 7)

         XCTAssertTrue(production.units == 3)
         XCTAssertTrue(production.spentUnits == 7, "Spent: \(production.spentUnits)")
     }

    func testProductionDidReset() {
        var production = Production()
        production.add(10)

        XCTAssertNoThrow(try production.canSpend(7))
        production.decreaseProduction(by: 7)

        XCTAssertTrue(production.units == 3)

        production.reset()
        XCTAssertTrue(production.units == 10)
        XCTAssertTrue(production.spentUnits == 0)
    }
}
