//
//  SpendingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Testing the Spending struct

class SpendingTests: EngineYardTests {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCannotSpendZero() throws {
        let handler = Spender()
        let amount = 0

        do {
            let _ = try handler.spend(amount: amount)
            XCTFail("Spend succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            let reason = error.reason
            XCTAssertEqual(reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testCannotSpendNegative() throws {
        let handler = Spender()
        let amount = -1

        try assert( handler.spend(amount: amount) , throwsErrorOfType: SpendingMoneyError.self)

        do {
            let _ = try handler.spend(amount: amount)
            XCTFail("Spend succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testCannotSpendMoreThanFunds() throws {
        let handler = Spender(3)
        let amount = 5

        try assert( handler.spend(amount: amount) , throwsErrorOfType: SpendingMoneyError.self)

        do {
            let _ = try handler.spend(amount: amount)
            XCTFail("Spend succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.notEnoughFunds(amount: amount))
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testDidSpendToZero() throws {
        let amount = 3
        let spender = Spender(amount)

        let result = try spender.spend(amount: amount)

        XCTAssertEqual(result, 0)
    }

    func testGameErrorDidThrowMoneyError() throws {
        let amount = 3
        let handler = Spender()

        try assert( handler.spend(amount: amount) , throwsErrorOfType: SpendingMoneyError.self)

        do {
            let _ = try handler.spend(amount: amount)
            XCTFail("Spend succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testErrorDescriptions() throws {
        let amount = 1
        let notEnoughFunds = SpendingMoneyError(
            reason: SpendingMoneyErrorReason.notEnoughFunds(amount: amount)
        )

        XCTAssertEqual(notEnoughFunds.description, """
            Encountered error'.
            Reason: notEnoughFunds(amount: \(amount))
            """)
    }

}
