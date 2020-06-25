//
//  TestBundleCanParseJSON.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BundleLoadTests: XCTestCase {

    override func setUpWithError() throws {
       // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanLoadLocal() throws {
        let bundle = Bundle(for: type(of: self))
        let resourceFile = Constants.boardJSONFile

        print ("attempting file >> \(resourceFile)")

        guard let url = bundle.url(forResource: resourceFile, withExtension: nil) else {
            XCTFail("Missing file: \(resourceFile))")
            return
        }

        print ("attempting url >> \(url as Any)")

        let data = try Data(contentsOf: url)
        XCTAssertTrue(data.count > 0)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(Response.self, from: data)

        XCTAssertNotNil(response.meta)
    }

    func testBundleDidDecodeViaExtension() throws {
        let bundle = Bundle(for: type(of: self))
        let resourceFile = Constants.boardJSONFile
        let response = try bundle.decode(Response.self, from: resourceFile)

        XCTAssertNotNil(response.meta)
    }

    func testDataLoader_DidDecode() throws {
        let bundle = Bundle(for: type(of: self))
        let file = Constants.boardJSONFile
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: file)

        switch result {
        case .success(let response):
            print ("RESPONSE FOUND")
            XCTAssertNotNil(response.meta)

        case .failure(let error):
            throw(error)
        }
    }

}
