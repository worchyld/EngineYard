//
//  BoardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardTests: XCTestCase {

    private var board: Board!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
    }

    func testBoardHasExpectedNumberOfPositions() {
        XCTAssertTrue(board.positions.count == Constants.totalBoardPositions)
    }

    func testBoardHasExpectedNumberOfCards() {
        XCTAssertTrue(board.allCards.count == Constants.totalCards)
    }

    func testQtyOfGreenCardsIsCorrect() {
        let expected = Constants.Family.Color.green.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .green).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyForRedCardsIsCorrect() {
        let expected = Constants.Family.Color.red.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .red).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyForBlueCardsIsCorrect() {
        let expected = Constants.Family.Color.blue.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .blue).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyForYellowCardsIsCorrect() {
        let expected = Constants.Family.Color.yellow.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .yellow).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyOfFirstGenerationCardsIsCorrect() {
        let expected = Constants.Family.Generation.first.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(generation: .first).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyOfSecondGenerationCardsIsCorrect() {
        let expected = Constants.Family.Generation.second.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(generation: .second).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }
}
