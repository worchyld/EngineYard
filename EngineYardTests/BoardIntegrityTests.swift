//
//  BoardIntegrityTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardIntegrityTests: XCTestCase {

    private var board: Board!
    lazy var allCards: [Card]? = {
        return board.getAllCards()
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
    }

    func testBoardHasExpectedNumberOfPositions() {
        XCTAssertTrue(board.positions.count == Constants.totalBoardPositions)
    }

    func testBoardHasExpectedNumberOfCards() -> [Card] {
        guard let cards = self.allCards else {
            XCTFail()
            return []
        }
        XCTAssertTrue(cards.count == Constants.totalCards)
        return cards
    }

    func testQtyOfGreenCardsIsCorrect() {
        let expected = Constants.Family.Color.green.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .green).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyForRedCardsIsCorrect() {
        let expected = Constants.Family.Color.red.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .red).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyForBlueCardsIsCorrect() {
        let expected = Constants.Family.Color.blue.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .blue).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyForYellowCardsIsCorrect() {
        let expected = Constants.Family.Color.yellow.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(color: .yellow).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFirstGenerationCardsIsCorrect() {
        let expected = Constants.Family.Generation.first.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(generation: .first).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfSecondGenerationCardsIsCorrect() {
        let expected = Constants.Family.Generation.second.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(generation: .second).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfThirdGenerationCardsIsCorrect() {
        let expected = Constants.Family.Generation.third.ExpectedTotalCards
        let qty = board.getAllCardsThatMatch(generation: .third).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFourthGenerationCardsIsCorrect() {
       let expected = Constants.Family.Generation.fourth.ExpectedTotalCards
       let qty = board.getAllCardsThatMatch(generation: .fourth).count
       XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFifthGenerationCardsIsCorrect() {
       let expected = Constants.Family.Generation.fifth.ExpectedTotalCards
       let qty = board.getAllCardsThatMatch(generation: .fifth).count
       XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testSumOfCapacity() {
        let positions = board.positions
        let sumOfOrderCapacity = positions.reduce(0, {$0 + $1.orderCapacity} )
        let expected = Constants.sumOfOrderCapacity
        XCTAssertTrue(sumOfOrderCapacity == expected, "sumOfOrderCapacity: \(sumOfOrderCapacity) vs \(expected)")
    }

    func testSumOfCosts() {
        let cards = testBoardHasExpectedNumberOfCards()
        let sumOfCosts = cards.reduce(0, {$0 + $1.cost})
        let expected = Constants.sumOfCosts
        XCTAssertTrue(sumOfCosts == expected, "\(sumOfCosts) vs \(expected)")
    }
}
