//
//  BoardIntegrityTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests the board after initialisation from code to ensure that:
// All cards, decks, quantities matches expectations
//
class BoardIntegrityTests: XCTestCase {

    private var sut: Board!
    lazy var allCards: [Card]? = {
        return self.sut.positions.compactMap({$0.cards}).flatMap { $0 }
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = self.testBoardIsNotNil()
    }

    func testBoardIsNotNil() -> Board {
        let board = Board()
        XCTAssertNotNil(board)
        return board
    }

    func testBoardHasExpectedNumberOfPositions() {
        XCTAssertTrue(sut.positions.count == Constants.totalBoardPositions)
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
        // run report
        let report = Constants.Expected.init(color: .green, generation: nil)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(color: .green).count
        XCTAssertTrue(qty == expected)
    }

    func testQtyForRedCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: .red, generation: nil)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(color: .red).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyForBlueCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: .blue, generation: nil)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(color: .blue).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyForYellowCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: .yellow, generation: nil)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(color: .yellow).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFirstGenerationCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: nil , generation: .first)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(generation: .first).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfSecondGenerationCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: nil , generation: .second)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(generation: .second).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfThirdGenerationCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: nil , generation: .third)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(generation: .third).count
        XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFourthGenerationCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: nil , generation: .fourth)
        let expected = report.results

       let qty = sut.getAllCardsThatMatch(generation: .fourth).count
       XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfFifthGenerationCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: nil , generation: .fifth)
        let expected = report.results

       let qty = sut.getAllCardsThatMatch(generation: .fifth).count
       XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testQtyOfGreenFirstCardsIsCorrect() {
        // run report
        let report = Constants.Expected.init(color: .green , generation: .first)
        let expected = report.results

        let qty = sut.getAllCardsThatMatch(color: .green, andGeneration: .first).count

       XCTAssertTrue(qty == expected, "qty: \(qty) vs \(expected)")
    }

    func testSumOfCapacity() {
        let positions = sut.positions
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
