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

    private weak var bundle: Bundle?
    private var loader: PListFileLoader?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        self.loader = PListFileLoader(bundle: bundle)
        self.bundle = bundle
    }

    func test_bundle() {
        guard let bundle = self.bundle else {
            XCTFail("No bundle found")
            return
        }
        XCTAssertNotNil(bundle.resourceURL)
        XCTAssertNotNil(bundle.bundlePath)
        XCTAssertNotNil(bundle.bundleURL)
    }

    func test_can_load_plist_file() {
        guard let loader = self.loader else {
            XCTFail("Loader not found")
            return
        }
        XCTAssertNoThrow(try loader.load(filename: "data.plist"), "Error was thrown")
        XCTAssertNotNil(loader)
    }

}
