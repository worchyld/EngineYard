//
//  WinnerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WinnerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testHasReachedGoal() {
        let coins = Constants.endGameCashTrigger
        XCTAssertTrue( Constants.hasReachedGoal(coins) )
    }

    func testHasZeroWinners() {
        let coins = [0, 329, 291, 52]

        let filter = coins.filter { (value) -> Bool in
            return Constants.hasReachedGoal(value)
        }

        XCTAssertTrue(filter.count == 0)
    }

    func testHasOneWinner() {
        let coins = [0, 330, 291, 52]

        let filter = coins.filter { (value) -> Bool in
            return Constants.hasReachedGoal(value)
        }

        XCTAssertTrue(filter.count == 1)
    }

    func testHasMultipleWinners() {
        let coins = [0, 330, 339, 52]

        let filter = coins.filter { (value) -> Bool in
            return Constants.hasReachedGoal(value)
        }

        XCTAssertTrue(filter.count == 2)
    }

}
