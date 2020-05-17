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

    func testCardQtyForGreenFamilyIsCorrect() {
        let expected = Constants.Family.Color.green.ExpectedTotals
        let qtyOfGreenCards = board.getAllCardsThatMatch(color: .green).count
        XCTAssertTrue(qtyOfGreenCards == expected)
    }

    
}
