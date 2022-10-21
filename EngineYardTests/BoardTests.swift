//
//  BoardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/10/2022.
//

import XCTest
@testable import EngineYard

final class BoardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardDidPrepare() throws {
        let board = Board()
        board.prepare()
        XCTAssertTrue(board.decks.count == Constants.totalDecks, "Expected: \(Constants.totalDecks), Got: \(board.decks.count)")
//        
//        let totalCards = board.decks.map {
//            return $0.cards.count
//        }.count
//        
//        XCTAssertTrue(totalCards == Constants.totalCards, "Expected \(Constants.totalCards), Got: \(totalCards)")
    }

}
