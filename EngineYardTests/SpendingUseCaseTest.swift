//
//  SpendingUseCaseTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Test the spending use case protocols

class SpendingUseCaseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositiveCheck_ThrowsOnZero() {
        let spender = Spender()

        XCTAssertThrowsError(try spender.checkPositive(amount: 0) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(0) )
        }
    }

    func testPositiveCheck_ThrowsOnNegative() {
        let spender = Spender()

        XCTAssertThrowsError(try spender.checkPositive(amount: -5) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(-5) )
        }
    }

    func testPositiveCheck_NoThrowOnPositive() {
        let spender = Spender()
        XCTAssertNoThrow( try spender.checkPositive(amount: 2) )

    }

    // ---


    func testCannotSpend() {
        let spender = Spender(value: 3)

        XCTAssertThrowsError(try spender.canSpend(amount: 5) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(5) )
        }
    }

    func testCanSpend() {
        let spender = Spender(value: 3)
        XCTAssertNoThrow( try spender.canSpend(amount: 2) )

    }

    func testCanSpend_FailsOnZero() {
        let spender = Spender(value: 3)

        XCTAssertThrowsError(try spender.canSpend(amount: 0) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(0) )
        }
    }

    func testSpendMoreThanFunds_Fails() {
        let spender = Spender.init(value: 3)

        XCTAssertThrowsError(try spender.canSpend(amount: 5) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(5) )
        }
    }

    func testDidSpend_5CoinsEqualsZero() {
        var spender = Spender.init(value: 5)
        let amount = 5

        XCTAssertNoThrow( try spender.spend(amount: amount) )

        XCTAssertEqual( spender.value, 0 )
    }


}
