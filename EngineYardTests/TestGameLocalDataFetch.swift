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

    var response: Response?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let bundle = Bundle(for: type(of: self))
        let api = FixturesLoaderAPI.shared

        api.fetchFixtures(from: bundle) { [weak self] result in
            switch result {
            case .success(let response):

                self?.response = response


            case .failure(let error):
                print(error.localizedDescription)
                XCTFail(error.localizedDescription)
            }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI_FetchFixtures() throws {
        print ("RESPONSE >> \(response as Any)")
    }
}
