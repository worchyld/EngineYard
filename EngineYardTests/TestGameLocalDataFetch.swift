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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalFileProvider() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "board.json", withExtension: nil) else {
            XCTFail("No url provided")
            return
        }

        let fileProvider = LocalFileProvider()

        fileProvider.requestLocalFile(from: url) { (result) in
            switch result {
            case .success(let data):
                print ("Response -->> \(data)")
                XCTAssertTrue(data.count > 0)
                
            case .failure(let error):
                print ("Error -->> \(error.localizedDescription) ")
                XCTFail(error.localizedDescription)
            }
        }
    }

}
