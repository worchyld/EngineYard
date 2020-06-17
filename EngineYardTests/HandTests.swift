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
        XCTAssertTrue(hand.size == 0)
        XCTAssertTrue(hand.isEmpty)
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

        XCTAssertFalse(hand.isEmpty)
        XCTAssertTrue(hand.size == 1)

        let firstCardInHand = hand.cards.first

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
        XCTAssertFalse(hand.cards.isEmpty)
        XCTAssertTrue(hand.cards.count == 1)

        XCTAssertThrowsError(try hand.add(card)) { error in
            XCTAssertEqual(error as! HandError, HandError.duplicateCardFound)
        }
    }

    func testCannotAddCardFromExactSameFamily() {
        let cards = Card.build()

        let greenCards = cards.filter { $0.color == .green && $0.generation == .first && $0.cost == 4 }

        XCTAssertFalse(greenCards.isEmpty)
        XCTAssertTrue(greenCards.count == 4)

        let firstCard = greenCards[0]
        let secondCard = greenCards[1]

        let hand = Hand.init()

        XCTAssertNoThrow(try hand.add(firstCard))
        XCTAssertFalse(hand.isEmpty)
        XCTAssertTrue(hand.cards.count == 1)

        XCTAssertThrowsError(try hand.add(secondCard)) { error in
            let group = LocomotiveGroup.init(color: .green, generation: .first)
            XCTAssertEqual(error as! HandError, HandError.alreadyHaveCardFromThisGroup(group) )
        }
    }

    func testCanAddCardFromDifferentGenerationButSameColor() {
        let cards = Card.build()

        let green1stGen = cards.filter { (c: Card) -> Bool in
            return (c.color == .green && c.generation == .first)
        }.first

        let green2ndGen = cards.filter { (c: Card) -> Bool in
            return (c.color == .green && c.generation == .second)
        }.first

        XCTAssertNotNil(green1stGen)
        XCTAssertNotNil(green2ndGen)

        guard let card1 = green1stGen else {
            XCTFail("No card found")
            return
        }

        guard let card2 = green2ndGen else {
            XCTFail("No card found")
            return
        }

        let hand = Hand.init()
        XCTAssertNoThrow( try hand.add(card1) )
        XCTAssertNoThrow( try hand.add(card2) )

        XCTAssertNotNil(hand.cards)
        XCTAssertFalse(hand.isEmpty)
        XCTAssertTrue(hand.cards.count == 2)
    }

}
