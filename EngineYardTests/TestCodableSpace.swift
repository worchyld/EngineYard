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
        guard let data = loadData(from: "board.json") else {
            XCTFail("No data found")
            return
        }
        XCTAssertTrue(data.count > 0)
    }

    func testLocalJSON() {

        guard let data = loadData(from: "board.json") else {
            XCTFail("No data found")
            return
        }

//        do {
//            let response = try data.decoded() as Response
//            print (response)
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }

        self.parseJSON(from: data) { (response, error) in
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


    func loadData(from filename: String) -> Data? {

        let bundle = Bundle(for: type(of: self))
        debugInfo(bundle: bundle)

        if let url = bundle.url(forResource: filename, withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    func parseJSON(from data: Data, completionBlock: @escaping (Response?, Error?) -> ()) {
        let decoder = JSONDecoder.init()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970

        do {
            let jsonResponse = try decoder.decode(Response.self, from: data)
            completionBlock(jsonResponse, nil)
        } catch {
            completionBlock(nil, error)
        }
    }

    func debugInfo(bundle: Bundle) {
        print ("\n\n--Bundle debug----")
        print ("bundle path: \(bundle.bundlePath)")
        print ("bundle loaded: \(bundle.isLoaded)")
        print ("Identifier:  \(bundle.bundleIdentifier as Any)")
        print ("Preferred localisations: \(bundle.preferredLocalizations)")
        print ("Dev Localisation: \(bundle.developmentLocalization as Any)")
        print ("----------------\n\n")
    }


}
