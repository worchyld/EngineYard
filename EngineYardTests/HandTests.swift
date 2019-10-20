//
//  HandTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 20/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class HandTests: EngineYardTests {

    var game: GameModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let mockPlayers = SetupManager.createPlayers(howMany: 5) else {
            XCTFail("Invalid player creation")
            return
        }
        guard let gameObj = SetupManager.instance.setup(players: mockPlayers) else {
            XCTFail("no game")
            return
        }
        self.game = gameObj
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Expect: Cannot add duplicate card
    func testAddDuplicateCard() {
        guard let game = self.game else {
            XCTFail("No game")
            return
        }
        guard let players: [Player] = game.players as? [Player] else {
            XCTFail("No players")
            return
        }
        guard let firstPlayer: Player = players.first else {
            XCTFail("No first player")
            return
        }
        guard let firstDeck = game.board?.decks.first else {
            XCTFail("No first deck")
            return
        }
        guard let firstCard = Deck.findFirstUnownedCard(in: firstDeck) else {
            XCTFail("No first card")
            return
        }

        if let result = (firstPlayer.hand.push(card: firstCard)) {
            XCTFail(String(describing: result))
        }

        // Add same card
        XCTAssertThrowsError( (firstPlayer.hand.push(card: firstCard))  )
    }

    // Expect: Cannot add card from same parent
    func testSameParent() {

    }

    // Expect: Don't add card if can't afford it
    func testCannotAffordCard() {

    }

    // #TODO: Remove card from hand
}
