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

    func testDidBuildCards() {
        let cards = Card.build()
        XCTAssertTrue(cards.count == Expected.totalCardsInGame)
    }

    func testNumberOfGreenCards() {
        let cards = Card.build()
        let color = Family.Color.green
        let expected = Expected.init(color: color, generation: nil)

        let found = self.getAllCardsThatMatch(cards, color: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testNumberOfRedCards() {
        let cards = Card.build()
        let color = Family.Color.red
        let expected = Expected.init(color: color, generation: nil)

        let found = self.getAllCardsThatMatch(cards, color: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testNumberOfYellowCards() {
        let cards = Card.build()
        let color = Family.Color.yellow
        let expected = Expected.init(color: color, generation: nil)

        let found = self.getAllCardsThatMatch(cards, color: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testNumberOfBlueCards() {
        let cards = Card.build()
        let color = Family.Color.blue
        let expected = Expected.init(color: color, generation: nil)

        let found = self.getAllCardsThatMatch(cards, color: color).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    private func getAllCardsThatMatch(_ cards: [Card], color: Family.Color) -> [Card] {

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
}
