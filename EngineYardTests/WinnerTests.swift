//
//  WinnerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 03/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

class WinnerTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndCashGoal() {
        let values = [0,299,300,329,330,331]

        let filtered = values.filter({
            return Constants.hasReachedGoal($0)
        })

        XCTAssertTrue(filtered.count == 2)
    }

    func testWinningPlayer() {
        let players = Mock.players(howMany: 5)!

        var filtered = players.filter({
            return Constants.hasReachedGoal($0.cash)
        })

        XCTAssertTrue(filtered.count == 0)

        guard let firstPlayer = players.first else {
            XCTFail("No first player")
            return
        }

        let amount = 330
        do {
            let _ = try (firstPlayer.wallet.credit(amount: amount))
        } catch {
            XCTFail("\(error)")
            return
        }

        filtered = players.filter({
            return (Constants.hasReachedGoal($0.cash))
        })

        XCTAssertTrue(filtered.count == 1)


    }

}
