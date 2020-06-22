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

    var meta : Meta!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
