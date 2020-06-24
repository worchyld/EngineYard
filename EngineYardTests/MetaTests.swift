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
        XCTAssertEqual( meta.cards, 43 )

        // Meta liveries / colors
        XCTAssertEqual( meta.liveries.total , 43)
        XCTAssertEqual( meta.liveries.green , 20)
        XCTAssertEqual( meta.liveries.red , 13)
        XCTAssertEqual( meta.liveries.yellow , 7)
        XCTAssertEqual( meta.liveries.blue , 3)

        // Meta first generation
        XCTAssertEqual( meta.generations.first.total , 10)
        XCTAssertEqual( meta.generations.first.green , 4)
        XCTAssertEqual( meta.generations.first.red , 3)
        XCTAssertEqual( meta.generations.first.blue, 1)
        XCTAssertEqual( meta.generations.first.yellow , 2)

        // Meta second generation
        XCTAssertEqual( meta.generations.second.total , 11)
        XCTAssertEqual( meta.generations.second.green , 4)
        XCTAssertEqual( meta.generations.second.red , 3)
        XCTAssertEqual( meta.generations.second.blue, 2)
        XCTAssertEqual( meta.generations.second.yellow , 2)

        // Meta third generation
        XCTAssertEqual( meta.generations.third.total , 10)
        XCTAssertEqual( meta.generations.third.green , 4)
        XCTAssertEqual( meta.generations.third.red , 3)
        XCTAssertEqual( meta.generations.third.blue, 0)
        XCTAssertEqual( meta.generations.third.yellow , 3)

        // Meta fourth generation
        XCTAssertEqual( meta.generations.fourth.total , 8)
        XCTAssertEqual( meta.generations.fourth.green , 4)
        XCTAssertEqual( meta.generations.fourth.red , 4)
        XCTAssertEqual( meta.generations.fourth.blue, 0)
        XCTAssertEqual( meta.generations.fourth.yellow , 0)

        // Meta fifth generation
        XCTAssertEqual( meta.generations.fifth.total , 4)
        XCTAssertEqual( meta.generations.fifth.green , 4)
        XCTAssertEqual( meta.generations.fifth.red , 0)
        XCTAssertEqual( meta.generations.fifth.blue, 0)
        XCTAssertEqual( meta.generations.fifth.yellow , 0)


        // Test meta livery totals ---

        let totalLiveries = {
            return meta.liveries.green +
                meta.liveries.red +
                meta.liveries.yellow +
                meta.liveries.blue
        }()

        XCTAssertEqual(
            totalLiveries
            ,
            meta.liveries.total
        )

        // Test meta generation totals
        let totalGenerations = {
            return meta.generations.first.total +
                meta.generations.second.total +
                meta.generations.third.total +
                meta.generations.fourth.total +
                meta.generations.fifth.total
        }()

        XCTAssertEqual(
            totalGenerations
            ,
            meta.cards
        )



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
