//
//  HandTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class HandTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testHandIsEmpty() {
        let hand = Hand.init()
        XCTAssertNil(hand.cards)
    }

    func testCanAddCard() {
        let cards = Card.build()
        guard let card = cards.first else {
            XCTFail("no first card found")
            return
        }
        let hand = Hand.init()

        XCTAssertNoThrow(try hand.canAdd(card))
        XCTAssertTrue(try hand.canAdd(card))
    }

    func testDidAddCard() {
        let cards = Card.build()
        guard let card = cards.first else {
            XCTFail("no first card found")
            return
        }
        let hand = Hand.init()

        XCTAssertNoThrow(try hand.add(card))

        guard let handCards = hand.cards else {
            XCTFail("No hand of cards found")
            return
        }

        XCTAssertTrue(handCards.count == 1)

        let firstCardInHand = handCards.first!

        XCTAssertTrue(firstCardInHand == card)
    }

    func testCannotAddDuplicateCard() {
        let cards = Card.build()
        guard let card = cards.first else {
            XCTFail("no first card found")
            return
        }
        let hand = Hand.init()

        XCTAssertNoThrow(try hand.add(card))
        XCTAssertTrue(hand.cards?.count == 1)

        XCTAssertThrowsError(try hand.add(card)) { error in
            XCTAssertEqual(error as! HandError, HandError.duplicateCardFound)
        }
    }

    

}
