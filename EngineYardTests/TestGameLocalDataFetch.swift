//
//  TestGameLocalDataFetch.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TestGameLocalDataFetch: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanLoadData() {
        let bundle = Bundle(for: type(of: self))
        let resource = "board.json"

        let resourceInfo = GameLocalDataAPI.ResourceInfo.init(bundle: bundle,
                                                              resource: resource, resourceType: nil)

        let api = GameLocalDataAPI.init(resourceInfo: resourceInfo)
        XCTAssertNoThrow(
            try api.fetchFixtures()
        )
    }

}
