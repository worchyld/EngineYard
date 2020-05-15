//
//  BoardInitializerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import EngineYard

@testable import EngineYard

// Tests a board

class BoardInitializerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBoardDidLoad() {
        BoardLoaderManager.loadBoard { (board, error)  in
            XCTAssertNotNil(board, "Board is nil")
            XCTAssertNotNil(error, error.debugDescription)
        }
    }

    func testBoardHasExpectedData() {
        let testExpectation = expectation(description: "totalDecks = 14")

        //[weak self]
        BoardLoaderManager.loadBoard { (board, error)  in
            guard let board = board else {
                XCTFail("Board is nil")
                return
            }
            let decks = board.decks

            // Expected `totalDecks` == 14
            XCTAssertTrue(decks.count == Board.ExpectedData.totalDecks)
            testExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    /*
    func testHasExpectedTotalCards(decks: [Deck]) {
        // Expected `totalCards` = 43
        let totalCards = decks.reduce(0, { $0 + $1.cards.count })
        let flattened = decks.compactMap { $0 }.reduce(0, { $0 + $1.cards.count })

        XCTAssertTrue(totalCards == Board.ExpectedData.totalCards, "\(totalCards)")
        print ("FLATTENED: \(flattened)")
    }

    func testSumOfCapacity(decks: [Deck]) {
        // Expected `sumOfCapacity` = 46
        let sumOfCapacity = decks.reduce(0, {$0 + $1.orderCapacity})
        XCTAssertTrue(sumOfCapacity == Board.ExpectedData.sumOfCapacity)
    }

    func testSumOfCosts(decks: [Deck]) {
        // Expected `sumOfCosts` = 420
        let sumOfCosts = decks.reduce(0, {$0 + $1.cost})
        XCTAssertTrue(sumOfCosts == Board.ExpectedData.sumOfCosts)
    }

    func testSumOfGenerations(decks: [Deck]) {
        // Expected `sumOfGenerations` = 34
        let sumOfGenerations = decks.reduce(0, {$0 + $1.generation})
        XCTAssertTrue(sumOfGenerations == Board.ExpectedData.sumOfGenerations)
    }

    func testSumOfColors(decks: [Deck]) {
        // Expected `sumOfColors` = 30
        let sumOfColors = decks.reduce(0, {$0 + $1.color})
        XCTAssertTrue(sumOfColors == Board.ExpectedData.sumOfColors)
    }
 */
}
