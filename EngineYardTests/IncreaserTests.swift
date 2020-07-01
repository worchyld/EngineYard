//
//  IncreaserTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests against the Increment class
class IncreaserTests: EngineYardTests {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCannotIncrementZero() throws {
        let handler = Increaser()
        let amount = 0

        try assert( handler.increase(by: amount) , throwsErrorOfType: SpendingMoneyError.self)

        do {
            let _ = try handler.increase(by: amount)
            XCTFail("Spend succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testCannotIncrementNegativeInt() throws {
        let handler = Increaser()
        let amount = -1

        try assert( handler.increase(by: amount) , throwsErrorOfType: SpendingMoneyError.self)
    }

    func testCanIncreasePositiveInt() throws {
        var amount = 1
        let increaser = Increaser(amount)

        amount = try increaser.increase(by: 4)

        XCTAssertEqual(amount, 5)
    }
    
}
