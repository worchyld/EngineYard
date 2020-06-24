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

        // Test against meta
        guard let meta = response.meta else {
            XCTFail("No meta found")
            return
        }

        XCTAssertEqual( meta.spaces,  14 )
        XCTAssertEqual( meta.totalCapacity,  46 )

        XCTAssertEqual( meta.cards.total, 43 )

        example(of: "Expecting 20 green", {
            let expected = 20
            XCTAssertEqual( meta.cards.green.total, expected )
            XCTAssertEqual( meta.cards.green.generations.count, 5 )
            XCTAssertEqual( meta.cards.green.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.green.generations.reduce(0, +) , meta.cards.green.total)
        })


        example(of: "Expecting 13 red", {
            let expected = 13
            XCTAssertEqual( meta.cards.red.total, 13 )
            XCTAssertEqual( meta.cards.red.generations.count, 5 )
            XCTAssertEqual( meta.cards.red.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.red.generations.reduce(0, +) , meta.cards.red.total)
        })

        example(of: "Expecting 7 yellow", {
            let expected = 7
            XCTAssertEqual( meta.cards.yellow.total, 7 )
            XCTAssertEqual( meta.cards.yellow.generations.count, 5 )
            XCTAssertEqual( meta.cards.yellow.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.yellow.generations.reduce(0, +) , meta.cards.yellow.total)
        })

        example(of: "Expecting 3 blue", {
            let expected = 3
            XCTAssertEqual( meta.cards.blue.total, 3 )
            XCTAssertEqual( meta.cards.blue.generations.count, 5 )
            XCTAssertEqual( meta.cards.blue.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.blue.generations.reduce(0, +) , meta.cards.blue.total)
        })
    }

    func testCanDecodeFromBundleExtension() throws {
        let bundle = Bundle(for: type(of: self))

        let response = try bundle.decode(Response.self, from: "board.json", dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)

        XCTAssertNotNil(response)
        XCTAssertNotNil(response.meta)
        XCTAssertNotNil(response.factories)
        XCTAssertNotNil(response.spaces)
        XCTAssertNotNil(response.locomotives)
    }

}
