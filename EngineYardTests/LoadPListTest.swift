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
        let loader = PListFileLoader()
        XCTAssertNotNil(loader)
        return loader
    }

    func testNoThrowImport() throws {
        let loader = try testLoaderNotNill()
        XCTAssertNoThrow(try loader.load(filename: "data.plist"), "Error was thrown")
    }

    func testFileHasData() throws -> Data {
        let loader = try testLoaderNotNill()
        let data = try loader.load(filename: "data.plist")
        XCTAssertNotNil(data)
        XCTAssertFalse(data.isEmpty)
        return data
    }

}
