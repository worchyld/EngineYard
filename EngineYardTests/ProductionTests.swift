//
//  ProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/05/2018.
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

    func testThreePlayerProduction() {
        // In a three-player game;
        let game : Game = Game(players: Mock.players(howMany: 3))

        let decks = game.board.decks.flatMap({
            $0.cards.filter({ (c:Card) -> Bool in
                return (c.production.units == 1)
            })
        })

        // Expect the first card in the game to have production.units
        // Expect this to 3 first-gen green cards only
        XCTAssertTrue(decks.count == 3)
        XCTAssertTrue(decks.first?.parent?.generation == .first && decks.first?.parent?.color == .green)

        let expectedColors = decks.map { (c:Card) -> Bool in
            return c.parent?.generation == .first && c.parent?.color == .green
        }
        XCTAssertTrue(expectedColors.count == 3)

        // Expect 3 cards to have production units == 1
        let total = game.board.decks.map ({
            $0.cards.filter({ (c: Card) -> Bool in
                return (c.production.units == 1)
            })
        }).reduce(0) {
            $0  + $1.count
        }

        XCTAssertTrue(total == 3, "Cards with production: \(total)")
    }


    func testFivePlayerProduction() {
        // In a five-player game;
        // Expect: No card should have any production.units
        let game : Game = Game(players: Mock.players(howMany: 5))

        let total = game.board.decks.map({
            $0.cards
                .filter({ (c:Card) -> Bool in
                    return c.production.units == 1
                })
        }).reduce(0) {
            $0  + $1.count
        }

        XCTAssertTrue(total == 0)
    }
    
    func testAddProduction() {
        let p:Production = Production()
        p.add(amount: 20)
        XCTAssertTrue(p.units == 20)
    }

    func testSpendProduction() {
        let p:Production = Production()
        p.add(amount: 20)
        p.spend(amount: 2)
        XCTAssertTrue(p.units == 18)
        XCTAssertTrue(p.spentUnits == 2)
    }

    func testResetProduction() {
        let p:Production = Production()
        p.add(amount: 20)
        p.spend(amount: 2)
        p.reset()
        XCTAssertTrue(p.units == 20)
        XCTAssertTrue(p.spentUnits == 0)
    }
}
