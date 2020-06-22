//
//  TestCodableSpace.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TestCodableSpace: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testLocalFileHasData() {

        let bundle = Bundle(for: type(of: self))
        let dataLoader = DataLoader.loadData(using: bundle, filename: "board.json")

        guard let data = dataLoader else {
            XCTFail("No data found")
            return
        }
        XCTAssertTrue(data.count > 0)
    }

    func testLocalJSON() {
        let bundle = Bundle(for: type(of: self))
        let dataLoader = DataLoader.loadData(using: bundle, filename: "board.json")

        guard let data = dataLoader else {
            XCTFail("No data found")
            return
        }

        JSONParser.decodeJSON(from: data) { (response, error) in
            if (error != nil) {
                XCTFail(error!.localizedDescription)
                return
            }
            guard let hasResponse = response else {
                XCTFail("response invalid")
                return
            }
            XCTAssertEqual(hasResponse.spaces?.count, 14)
            return
        }
    }

}