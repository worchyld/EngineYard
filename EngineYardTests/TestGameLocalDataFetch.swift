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

    var response: Response?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let bundle = Bundle(for: type(of: self))
        let api = FixturesLoaderAPI.shared

        api.fetchFixtures(from: bundle) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response


            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI_FetchFixtures() throws {

        guard let response = response else {
            XCTFail("No meta key found")
            return
        }
        guard let meta = response.meta else {
            XCTFail("No meta key found")
            return
        }
        guard let factories = response.factories else {
            return
        }
        guard let locomotives = response.locomotives else {
            XCTFail("No meta key found")
            return
        }
        guard let spaces = response.spaces else {
            return
        }

        XCTAssertEqual(meta.boardSpaces! , factories.count)
        XCTAssertEqual(meta.boardSpaces!, spaces.count)
        XCTAssertEqual(meta.cards?.total, locomotives.count)

    }
}
