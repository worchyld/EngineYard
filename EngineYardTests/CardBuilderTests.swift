//
//  CardBuilderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests for card builder

class CardBuilderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCardsBuiltEquals43() {
        let cards = Card.build()
        XCTAssertTrue(cards.count == Expected.totalCardsInGame)
    }

    func testGreenCardsEquals20() {
        let cards = Card.build()
        let color = Family.Color.green
        let expected = Expected.init(color: color, generation: nil)

        let found = self.filter(cards, for: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testRedCardsEquals13() {
        let cards = Card.build()
        let color = Family.Color.red
        let expected = Expected.init(color: color, generation: nil)

        let found = self.filter(cards, for: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testYellowCardsEquals7() {
        let cards = Card.build()
        let color = Family.Color.yellow
        let expected = Expected.init(color: color, generation: nil)

        let found = self.filter(cards, for: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testBlueCardsEquals3() {
        let cards = Card.build()
        let color = Family.Color.blue
        let expected = Expected.init(color: color, generation: nil)

        let found = self.filter(cards, for: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test1stGenerationEquals10() {
        // run report
        let cards = Card.build()
        let generation = Family.Generation.first
        let expected = Expected.init(color: nil , generation: generation)

        let found = self.filter(cards, for: generation).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test2ndGenerationEquals11() {
        // run report
        let cards = Card.build()
        let generation = Family.Generation.second
        let expected = Expected.init(color: nil , generation: generation)

        let found = self.filter(cards, for: generation).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test3rdGenerationEquals10() {
        // run report
        let cards = Card.build()
        let generation = Family.Generation.third
        let expected = Expected.init(color: nil , generation: generation)

        let found = self.filter(cards, for: generation).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test4thGenerationEquals8() {
        // run report
        let cards = Card.build()
        let generation = Family.Generation.fourth
        let expected = Expected.init(color: nil , generation: generation)

        let found = self.filter(cards, for: generation).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test5thGenerationEquals4() {
        // run report
        let cards = Card.build()
        let generation = Family.Generation.fifth
        let expected = Expected.init(color: nil , generation: generation)

        let found = self.filter(cards, for: generation).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }


    // MARK: (PRIVATE) functions
    // Helpers for filtering cards

    private func filter(_ cards: [Card], for color: Family.Color) -> [Card] {

        let filtered = cards.filter { (c: Card) -> Bool in
            return (c.color == color)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (
                (a.color.rawValue < b.color.rawValue) &&
                (a.cost < b.cost)
            )
        }

        return filtered
    }

    private func filter(_ cards: [Card], for generation: Family.Generation) -> [Card] {

        let filtered = cards.filter { (c: Card) -> Bool in
            return (c.generation == generation)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (
                (a.generation.rawValue < b.generation.rawValue) &&
                (a.cost < b.cost)
            )
        }
        return filtered
    }

    /*
    public func getAllCardsThatMatch(generation: Family.Generation) -> [Card] {
        let cards = self.getAllCards()

        let results = cards.filter { (c: Card) -> Bool in
            return (c.generation == generation)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (
                (a.generation.rawValue < b.generation.rawValue) &&
                (a.cost < b.cost)
            )
        }
        return results
    }*/
}
