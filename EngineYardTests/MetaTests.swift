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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMetaResponse() {

       //s let bundle = Bundle(for: type(of: self))
//
//        do {
//            guard let data = try DataLoader.loadData(using: bundle, filename: "board.json") else {
//                XCTFail("error")
//                return
//            }
//            guard data.count > 0 else {
//                XCTFail("No data found")
//                return
//            }
//
//            JSONParser.decodeJSON(from: data) { (response, error) in
//                if (error != nil) {
//                    XCTFail(error!.localizedDescription)
//                    return
//                }
//                guard let hasResponse = response else {
//                    XCTFail("response invalid")
//                    return
//                }
//
//                XCTAssertNotNil(hasResponse.meta)
//                guard let meta = hasResponse.meta else {
//                    XCTFail("meta fails")
//                    return
//                }
//
//                XCTAssertNotNil(meta.boardSpaces)
//                XCTAssertEqual(meta.boardSpaces, 14)
//                XCTAssertEqual(meta.cards?.total, 43)
//                // color meta
//                XCTAssertEqual(meta.cards?.liveries?.green, 20)
//                XCTAssertEqual(meta.cards?.liveries?.red, 13)
//                XCTAssertEqual(meta.cards?.liveries?.yellow, 7)
//                XCTAssertEqual(meta.cards?.liveries?.blue, 3)
//                // first generation meta
//                XCTAssertEqual(meta.cards?.generations?.first?.total, 10)
//                XCTAssertEqual(meta.cards?.generations?.first?.green, 4)
//                XCTAssertEqual(meta.cards?.generations?.first?.red, 3)
//                XCTAssertEqual(meta.cards?.generations?.first?.blue, 1)
//                XCTAssertEqual(meta.cards?.generations?.first?.yellow, 2)
//                // second generation meta
//                XCTAssertEqual(meta.cards?.generations?.second?.total, 11)
//                XCTAssertEqual(meta.cards?.generations?.second?.green, 4)
//                XCTAssertEqual(meta.cards?.generations?.second?.red, 3)
//                XCTAssertEqual(meta.cards?.generations?.second?.blue, 2)
//                XCTAssertEqual(meta.cards?.generations?.second?.yellow, 2)
//                // third generation meta
//                XCTAssertEqual(meta.cards?.generations?.third?.total, 10)
//                XCTAssertEqual(meta.cards?.generations?.third?.green, 4)
//                XCTAssertEqual(meta.cards?.generations?.third?.red, 3)
//                XCTAssertEqual(meta.cards?.generations?.third?.blue, 0)
//                XCTAssertEqual(meta.cards?.generations?.third?.yellow, 3)
//                // fourth generation meta
//                XCTAssertEqual(meta.cards?.generations?.fourth?.total, 8)
//                XCTAssertEqual(meta.cards?.generations?.fourth?.green, 4)
//                XCTAssertEqual(meta.cards?.generations?.fourth?.red, 4)
//                XCTAssertEqual(meta.cards?.generations?.fourth?.blue, 0)
//                XCTAssertEqual(meta.cards?.generations?.fourth?.yellow, 0)
//                // fifth generation meta
//                XCTAssertEqual(meta.cards?.generations?.fifth?.total, 4)
//                XCTAssertEqual(meta.cards?.generations?.fifth?.green, 4)
//                XCTAssertEqual(meta.cards?.generations?.fifth?.red, 0)
//                XCTAssertEqual(meta.cards?.generations?.fifth?.blue, 0)
//                XCTAssertEqual(meta.cards?.generations?.fifth?.yellow, 0)
//
//                return
//            }
//
//        } catch {
//            XCTFail(error.localizedDescription)
//            return
//        }



    }
}

private struct Expected {
    var totalBoardSpaces: Int?
    var totalCards: Int?

    init(meta: Meta) {
        if let totalBoardSpaces = meta.boardSpaces {
            self.totalBoardSpaces = totalBoardSpaces
        }
        if let totalCards = meta.cards?.total {
            self.totalCards = totalCards
        }
    }
}
