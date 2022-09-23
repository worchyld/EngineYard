//
//  HandManagementTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 23/09/2022.
//

import XCTest
@testable import EngineYard

final class HandManagementTests: XCTestCase {

    var board: Board?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
        self.board!.decks = self.board!.prepare()
    }

    func testCanAddSingleCard() throws {
        let hand = Hand()
        guard let firstCard = self.board!.decks.first!.cards.first else {
            return XCTFail()
        }
        let result = hand.seek(firstCard)
        XCTAssertFalse(result)
        
        hand.push(firstCard)
        
        XCTAssertTrue(hand.cards.count == 1)
    }

    func testCannotExactSameCard() throws {
        let hand = Hand()
        guard let firstCard = self.board!.decks.first!.cards.first else {
            return XCTFail()
        }
        let result = hand.seek(firstCard)
        XCTAssertFalse(result)

        XCTAssertNoThrow( let result = hand.canPush(firstCard) )
        
    }
}
