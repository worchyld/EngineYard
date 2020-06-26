//
//  MetaTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class DecodedDataTests: XCTestCase {

    var response: Response!
    var meta: Meta!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        let resourceFile = Constants.boardJSONFile

        self.meta = Meta.build()

        do {
            let response = try bundle.decode(Response.self, from: resourceFile)
            self.response = response
        }
        catch {
            throw error
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResponseItemsAreNotNil() throws {
        XCTAssertNotNil(response.factories)
    }

    func testMetaExpectations() throws {
        XCTAssertEqual( meta.factories,  14 )
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

    func testFactoriesEqualsSpaces() throws {
        guard let factories = response.factories else {
            throw NSError(domain: "No factories found", code: 0, userInfo: nil)
        }
        XCTAssertEqual(factories.count, meta.factories)
    }
    

    func testCapacities() throws {
        guard let factories = response.factories else {
            XCTFail("No factories found")
            return
        }

        let totalCapacity = factories.reduce(0, { $0 + $1.orderCapacity }  )
        XCTAssertEqual(totalCapacity, meta.totalCapacity)
    }


}
