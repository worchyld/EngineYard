//
//  LoadPListTest.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class LoadPListTest: XCTestCase {

    func testBundleNotNill() throws -> Bundle {
        let bundle = Bundle(for: type(of: self))
        XCTAssertNotNil(bundle)
        XCTAssertNotNil(bundle.resourcePath)
        XCTAssertNotNil(bundle.bundlePath)
        XCTAssertNotNil(bundle.bundleURL)
        return bundle
    }

    func testLoaderNotNill() throws -> PListFileLoader {
        let bundle = try testBundleNotNill()
        let loader = PListFileLoader(bundle: bundle)
        XCTAssertNotNil(loader)
        return loader
    }

    func testNoThrowImport() throws {
        let loader = try testLoaderNotNill()
        XCTAssertNoThrow(try loader.load(filename: "data.plist"), "Error was thrown")
    }

    func testImportPlistHasData() throws -> Data {
        let loader = try testLoaderNotNill()
        let data = try loader.load(filename: "data.plist")
        XCTAssertNotNil(data)
        XCTAssertFalse(data.isEmpty)
        return data
    }

    func testDataLoaderWithCompletionHandler() throws {
        let loader = try testLoaderNotNill()
        loader.getDataFrom(filename: "data.plist") { (data, error) in
            XCTAssertNotNil(data, "Data not found")
            XCTAssertNil(error, error.debugDescription)
        }
    }

    func testPropertyListDecoder() throws {
        let data = try testImportPlistHasData()

        do {
            let decoder = PropertyListDecoder()
            let results = try decoder.decode(Board.self, from: data)

            XCTAssertTrue(results.decks.count > 0)
        } catch {
            // handle error
            print (error)
        }
    }
}
