//
//  LocomotiveBuilderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests against the `Locomotive` Buider extension

class LocomotiveBuilderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testTotalLocmotivesBuiltEquals14() {
        let locomotives = Locomotive.build()
        XCTAssertTrue(locomotives.count == Expected.totalLocomotivesInGame)
    }

 
}
