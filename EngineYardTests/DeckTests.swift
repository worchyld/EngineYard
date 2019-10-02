//
//  DeckTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

class DeckTests: EngineYardTests {

    private var board: Board?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        board = nil
    }

    func testDecksCount() {
        guard let board = self.board else {
            XCTFail("No board created")
            return
        }

        XCTAssert(board.decks.count == Meta.totalDecks)
    }

}
