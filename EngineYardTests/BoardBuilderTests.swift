//
//  BoardBuilderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardBuilderTests: XCTestCase {

    var board: Board!

    override func setUpWithError() throws {
        guard let board = EngineYardGame.loadInitialBoard() else {
            XCTFail("No board created")
            return
        }
        self.board = board
    }

    func testInitialBoardHas14Locomotives() {
        guard let board = self.board else {
            XCTFail("No board defined")
            return
        }
        XCTAssertTrue(board?.count == Expected.totalLocomotivesInGame)
    }

    func testInitialBoardSpaces() {
        guard let b = self.board else {
            XCTFail("No board defined")
            return
        }
        guard let board = b else {
            return
        }

        XCTAssertTrue(board[0].color == .green && board[0].generation == .first)
        XCTAssertTrue(board[1].color == .red && board[1].generation == .first)
        XCTAssertTrue(board[2].color == .yellow && board[2].generation == .first)
        XCTAssertTrue(board[3].color == .blue && board[3].generation == .first)
        XCTAssertTrue(board[4].color == .green && board[4].generation == .second)
        XCTAssertTrue(board[5].color == .red && board[5].generation == .second)
        XCTAssertTrue(board[6].color == .yellow && board[6].generation == .second)
        XCTAssertTrue(board[7].color == .green && board[7].generation == .third)
        XCTAssertTrue(board[8].color == .blue && board[8].generation == .second)
        XCTAssertTrue(board[9].color == .red && board[9].generation == .third)
        XCTAssertTrue(board[10].color == .green && board[10].generation == .fourth)
        XCTAssertTrue(board[11].color == .yellow && board[11].generation == .third)
        XCTAssertTrue(board[12].color == .red && board[12].generation == .fourth)
        XCTAssertTrue(board[13].color == .green && board[13].generation == .fifth)

        let _ = board.map() { d in
            //XCTAssertTrue(d.state == Locomotive.State.unavailable)
            XCTAssertTrue(d.orders.count == 0)
        }
    }


}
