//
//  ProductionHandlerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductionDidInit() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        XCTAssertEqual(fp.units, 1)
        XCTAssertEqual(fp.spent, 0)
    }

    func testProductionCannotSpendZero() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler.init(with: fp)
        let amount = 0

        XCTAssertThrowsError( try handler.spend(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testProductionCannotSpendNegative() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler.init(with: fp)
        let amount = -1

        XCTAssertThrowsError( try handler.spend(amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testProductionSpendsToZero() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler.init(with: fp)
        let amount = 1

        let result = try handler.spend(amount: amount)
        XCTAssertEqual(result, 0)
        XCTAssertEqual(fp.spent, 1)
    }

    func testProductionWhenSpending_IncreasedSpentAmount() throws {
        let units = 3
        let spend = 1
        let expected = (units - spend)
        let fp = FactoryProduction(id: UUID(), units: units)
        let handler = ProductionHandler.init(with: fp)

        let result = try handler.spend(amount: spend)
        XCTAssertEqual(result, expected)
        XCTAssertEqual(fp.spent, spend)
    }

    func testProductionSpendMultipleToZero() throws {
        let units = 5
        let fp = FactoryProduction(id: UUID(), units: units)
        let handler = ProductionHandler.init(with: fp)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        XCTAssertEqual(fp.units, 0)
        XCTAssertEqual(fp.spent, 5)

        XCTAssertThrowsError( try handler.spend(amount: 1) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(0) )
        }
    }

    func testProductionDidReset() throws {
        let units = 5
        let fp = FactoryProduction(id: UUID(), units: units)
        let handler = ProductionHandler.init(with: fp)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)
        let _ = try handler.spend(amount: 1)

        XCTAssertEqual(fp.units, 0)
        XCTAssertEqual(fp.spent, 5)

        handler.reset()

        XCTAssertEqual(fp.units, 5)
        XCTAssertEqual(fp.spent, 0)

    }

}
