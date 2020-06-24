//
//  MetaTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class MetaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "board", withExtension: "json") else {
            XCTFail("Missing file: board.json")
            return
        }

        let data = try Data(contentsOf: url)
        XCTAssertTrue(data.count > 0)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(Response.self, from: data)

        XCTAssertNotNil(response.meta)
        XCTAssertNotNil(response.factories)
        XCTAssertNotNil(response.spaces)
        XCTAssertNotNil(response.locomotives)

        let meta = response.meta
        XCTAssertNotNil(meta)

        // Test meta
        XCTAssertNotNil(meta?.boardSpaces)
        XCTAssertEqual(meta?.boardSpaces, 14)
        XCTAssertEqual(meta?.cards?.total, 43)
        // color meta
        XCTAssertEqual(meta?.cards?.liveries?.green, 20)
        XCTAssertEqual(meta?.cards?.liveries?.red, 13)
        XCTAssertEqual(meta?.cards?.liveries?.yellow, 7)
        XCTAssertEqual(meta?.cards?.liveries?.blue, 3)
        // first generation meta
        XCTAssertEqual(meta?.cards?.generations?.first?.total, 10)
        XCTAssertEqual(meta?.cards?.generations?.first?.green, 4)
        XCTAssertEqual(meta?.cards?.generations?.first?.red, 3)
        XCTAssertEqual(meta?.cards?.generations?.first?.blue, 1)
        XCTAssertEqual(meta?.cards?.generations?.first?.yellow, 2)
        // second generation meta
        XCTAssertEqual(meta?.cards?.generations?.second?.total, 11)
        XCTAssertEqual(meta?.cards?.generations?.second?.green, 4)
        XCTAssertEqual(meta?.cards?.generations?.second?.red, 3)
        XCTAssertEqual(meta?.cards?.generations?.second?.blue, 2)
        XCTAssertEqual(meta?.cards?.generations?.second?.yellow, 2)
        // third generation meta
        XCTAssertEqual(meta?.cards?.generations?.third?.total, 10)
        XCTAssertEqual(meta?.cards?.generations?.third?.green, 4)
        XCTAssertEqual(meta?.cards?.generations?.third?.red, 3)
        XCTAssertEqual(meta?.cards?.generations?.third?.blue, 0)
        XCTAssertEqual(meta?.cards?.generations?.third?.yellow, 3)
        // fourth generation meta
        XCTAssertEqual(meta?.cards?.generations?.fourth?.total, 8)
        XCTAssertEqual(meta?.cards?.generations?.fourth?.green, 4)
        XCTAssertEqual(meta?.cards?.generations?.fourth?.red, 4)
        XCTAssertEqual(meta?.cards?.generations?.fourth?.blue, 0)
        XCTAssertEqual(meta?.cards?.generations?.fourth?.yellow, 0)
        // fifth generation meta
        XCTAssertEqual(meta?.cards?.generations?.fifth?.total, 4)
        XCTAssertEqual(meta?.cards?.generations?.fifth?.green, 4)
        XCTAssertEqual(meta?.cards?.generations?.fifth?.red, 0)
        XCTAssertEqual(meta?.cards?.generations?.fifth?.blue, 0)
        XCTAssertEqual(meta?.cards?.generations?.fifth?.yellow, 0)

    }

    func testCanDecodeFromBundleExtension() throws {
        let bundle = Bundle(for: type(of: self))

        let response = try bundle.decode(Response.self, from: "board.json", dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)

        XCTAssertNotNil(response)
        XCTAssertNotNil(response.meta)

    }
}
