//
//  FamilyTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class FamilyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testColorIsEquatable() {
        let color1 = LocomotiveGroup.init(color: .green, generation: .first)
        let color2 = LocomotiveGroup.init(color: .green, generation: .first)

        XCTAssertEqual(color1, color2)
    }

    func testGroupDescription() {
        let color1 = LocomotiveGroup.init(color: .green, generation: .first)
        XCTAssertTrue(color1.description == "Green 1st Generation", "\(color1.description)")
    }

    func testLocomotiveGroupDescription() {
        let loco = Locomotive.init("Green.1", 4, .green, .first, 4)
        XCTAssertTrue(loco.group.description == "Green 1st Generation", "\(loco.group.description)")
    }

}
