//
//  DeckUnlockTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class DeckUnlockTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialDecksAreInactive() {
        let board = Board()

        let _ = board.decks.map { (d: Deck) in
            XCTAssertTrue(d.state == .inactive)
        }
    }

    func testUnlockSingleDeck() {
        let board = Board()

        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck")
            return
        }

        XCTAssertTrue(firstDeck.state == .inactive)
        firstDeck.orderBook.add()
        XCTAssertTrue(firstDeck.state == .active)
        board.unlockNextDeck(after: firstDeck)

        let results = board.decks.filter { (d: Deck) in
            return (d.state == .active)
        }.count

        XCTAssertTrue(results == 2)
    }

}
