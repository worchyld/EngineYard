//
//  RollDieTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/03/2022.
//

import XCTest
@testable import EngineYard

class RollDieTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let d6 = Die.roll
        XCTAssertTrue(d6 > 0 && d6 < 7)
    }

}
