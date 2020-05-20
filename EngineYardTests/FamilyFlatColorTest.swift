//
//  FamilyFlatColorTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import UIKit

@testable import EngineYard

class FamilyFlatColorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFamilyFlatColorGreen() {
        let color = Family.Color.green
        XCTAssertTrue(color.flatColor == FlatColors.Emerald)
    }
    func testFamilyFlatColorRed() {
        let color = Family.Color.red
        XCTAssertTrue(color.flatColor == FlatColors.Alizarin)
    }
    func testFamilyFlatColorBlue() {
        let color = Family.Color.blue
        XCTAssertTrue(color.flatColor == FlatColors.PeterRiver)
    }
    func testFamilyFlatColorYellow() {
        let color = Family.Color.yellow
        XCTAssertTrue(color.flatColor == FlatColors.SunFlower)
    }

}
