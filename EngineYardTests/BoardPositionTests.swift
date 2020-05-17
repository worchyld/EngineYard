//
//  BoardPositionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardPositionTests: XCTestCase {

    private var board: Board!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFirstPosition() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        guard let firstPosition = board.positions.first else {
            XCTFail("No first position found")
            return
        }

        XCTAssertTrue(firstPosition.color == .green)
        XCTAssertTrue(firstPosition.generation == .first)
        XCTAssertTrue(firstPosition.state == .unavailable)
    }

    func testFirstPositionHasCards() {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }
        guard let firstPosition = board.positions.first else {
            XCTFail("No first position found")
            return
        }
        XCTAssertTrue(firstPosition.color == Family.Color.green)
        XCTAssertTrue(firstPosition.generation == Family.Generation.first)

        //let cards = firstPosition.cards
    }

}
