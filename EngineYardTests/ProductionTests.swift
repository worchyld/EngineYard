//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddProduction() {
        let p = Production()
        p.add(1)
        XCTAssertTrue(p.units == 1, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testSpendProduction() {
        let p = Production()
        p.add(1)

        XCTAssertNoThrow(try p.spend(1))
        XCTAssertTrue(p.units == 0, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 1, "Units \(p.spentUnits)")

        p.reset()

        XCTAssertTrue(p.units == 1)
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testInvalidSpend() {
        let p = Production()
        p.add(1)

        XCTAssertThrowsError(try p.spend(3)) { error in
            XCTAssertEqual(error as? ProductionError, ProductionError.notEnoughUnits)
        }

        XCTAssertTrue(p.units == 1, "Units: \(p.units)")
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testComplexSpend() {
        let p = Production()

        // expect units = 2, spend = 0
        p.add(2)
        XCTAssertNoThrow(try p.spend(1))
        XCTAssertTrue(p.spentUnits == 1, "spent: \(p.spentUnits)")

        // expect units = 1, spend = 2
        p.add(1)
        XCTAssertNoThrow(try p.spend(1))
        XCTAssertTrue(p.units == 1, "\(p.units)")
        XCTAssertTrue(p.spentUnits == 2, "\(p.spentUnits)")

        // expect units = 3, spend = 0
        p.reset()
        XCTAssertTrue(p.units == 3)
        XCTAssertTrue(p.spentUnits == 0)
    }

    func testCanShiftProduction() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        let firstTwoDecks = board.decks[0...1]
        guard let firstDeck = firstTwoDecks.first else {
            XCTFail("No first deck found")
            return
        }
        guard let lastDeck = firstTwoDecks.last else {
            XCTFail("No last deck found")
            return
        }
        guard let firstGreenCard = firstDeck.cards.first else {
            return
        }
        guard let firstRedCard = lastDeck.cards.first else {
            return
        }
        XCTAssertTrue(firstGreenCard.parent?.color == EngineColor.green)
        XCTAssertTrue(firstRedCard.parent?.color == EngineColor.red)

        XCTAssertTrue(firstDeck.productionCost == 2, "\(firstDeck.productionCost)")
        XCTAssertTrue(lastDeck.productionCost == 4, "\(lastDeck.productionCost)")

        guard let firstPlayer = game.players?.first as? Player else {
            print ("No player found")
            return
        }

        XCTAssertNoThrow(try firstPlayer.hand.add(firstGreenCard))

        let units = firstGreenCard.production.units

        let costToShift = Hand.costToShift(units: units, from: firstGreenCard, to: firstRedCard)

        XCTAssertTrue(costToShift == 2, "\(costToShift)")
    }

    // Cannot shift production `downstream` from a new tech to older tech
    func testCannotSelectDownstream() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        let firstTwoDecks = board.decks[0...1]
        guard let firstDeck = firstTwoDecks.first else {
            XCTFail("No first deck found")
            return
        }
        guard let lastDeck = firstTwoDecks.last else {
            XCTFail("No last deck found")
            return
        }
        guard let firstGreenCard = firstDeck.cards.first else {
            return
        }
        guard let firstRedCard = lastDeck.cards.first else {
            return
        }
        XCTAssertTrue(firstGreenCard.parent?.color == EngineColor.green)
        XCTAssertTrue(firstRedCard.parent?.color == EngineColor.red)

        XCTAssertTrue(firstDeck.productionCost == 2, "\(firstDeck.productionCost)")
        XCTAssertTrue(lastDeck.productionCost == 4, "\(lastDeck.productionCost)")


        guard let firstPlayer = game.players?.first as? Player else {
            print ("No player found")
            return
        }
        XCTAssertNoThrow(try firstPlayer.hand.add(firstGreenCard))
        XCTAssertNoThrow(try firstPlayer.hand.add(firstRedCard))

        XCTAssertThrowsError(try firstPlayer.hand.canShift(amount: 1, from: firstRedCard, to: firstGreenCard)
        ) { error in
            XCTAssertEqual(error as? HandError, HandError.cannotSelectDownstream)
        }

    }

    func testShiftProduction() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        let firstTwoDecks = board.decks[0...1]
        guard let firstDeck = firstTwoDecks.first else {
            XCTFail("No first deck found")
            return
        }
        guard let lastDeck = firstTwoDecks.last else {
            XCTFail("No last deck found")
            return
        }
        guard let firstGreenCard = firstDeck.cards.first else {
            return
        }
        guard let firstRedCard = lastDeck.cards.first else {
            return
        }

        guard let firstPlayer = game.players?.first as? Player else {
            print ("No player found")
            return
        }

        XCTAssertNoThrow(try firstPlayer.hand.add(firstGreenCard))

        let units = firstGreenCard.production.units

        XCTAssertThrowsError(try firstPlayer.hand.canShift(amount: units, from: firstGreenCard, to: firstRedCard)) { error in
            XCTAssertEqual(error as? HandError, HandError.cannotFindCard)
        }

        XCTAssertNoThrow(try firstPlayer.hand.add(firstRedCard))

        XCTAssertTrue(firstGreenCard.production.units == 1)
        XCTAssertTrue(firstRedCard.production.units == 1)

        guard let result1 = firstPlayer.hand.find(firstGreenCard) else {
            XCTFail("No green card found")
            return
        }
        guard let result2 = firstPlayer.hand.find(firstRedCard) else {
            XCTFail("No red card found")
            return
        }

        XCTAssertTrue(result1.1 == firstGreenCard)
        XCTAssertTrue(result2.1 == firstRedCard)


        XCTAssertNoThrow(try firstPlayer.hand.shift(units: units, from: firstGreenCard, to: firstRedCard))

        XCTAssertTrue(firstGreenCard.production.units == 0)
        XCTAssertTrue(firstRedCard.production.units == 2)

    }

}
