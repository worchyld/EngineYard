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
        let cash = [0,299,300,329,330,331]

        let filtered = cash.filter({
            return ($0 >= Constants.endGameCashTrigger)
        })

        XCTAssertTrue(filtered.count == 2)
    }

}
