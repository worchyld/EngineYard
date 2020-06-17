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
        let color = Locomotive.Color.green
        let expected = Expected.init(color: color, generation: nil)

        let found = Card.filter(cards: cards, matching: (color: color, generation: nil)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testRedCardsEquals13() {
        let cards = Card.build()
        let color = Locomotive.Color.red
        let expected = Expected.init(color: color, generation: nil)

        let found = Card.filter(cards: cards, matching: (color: color, generation: nil)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testYellowCardsEquals7() {
        let cards = Card.build()
        let color = Locomotive.Color.yellow
        let expected = Expected.init(color: color, generation: nil)

        let found = Card.filter(cards: cards, matching: (color: color, generation: nil)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testBlueCardsEquals3() {
        let cards = Card.build()
        let color = Locomotive.Color.blue
        let expected = Expected.init(color: color, generation: nil)

        let found = Card.filter(cards: cards, matching: (color: color, generation: nil)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test1stGenerationEquals10() {
        // run report
        let cards = Card.build()
        let generation = Locomotive.Generation.first
        let expected = Expected.init(color: nil , generation: generation)

        let found = Card.filter(cards: cards, matching: (color: nil, generation: generation)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test2ndGenerationEquals11() {
        // run report
        let cards = Card.build()
        let generation = Locomotive.Generation.second
        let expected = Expected.init(color: nil , generation: generation)

        let found = Card.filter(cards: cards, matching: (color: nil, generation: generation)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test3rdGenerationEquals10() {
        // run report
        let cards = Card.build()
        let generation = Locomotive.Generation.third
        let expected = Expected.init(color: nil , generation: generation)

        let found = Card.filter(cards: cards, matching: (color: nil, generation: generation)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test4thGenerationEquals8() {
        // run report
        let cards = Card.build()
        let generation = Locomotive.Generation.fourth
        let expected = Expected.init(color: nil , generation: generation)

        let found = Card.filter(cards: cards, matching: (color: nil, generation: generation)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func test5thGenerationEquals4() {
        // run report
        let cards = Card.build()
        let generation = Locomotive.Generation.fifth
        let expected = Expected.init(color: nil , generation: generation)

        let found = Card.filter(cards: cards, matching: (color: nil, generation: generation)).count

        XCTAssertTrue(found == expected.results, "Mismatch in expectations. Found: \(found), Expected \(expected)")
    }

    func testFamilyColorsEquals4() {
        let allColors = Locomotive.Color.allCases
        XCTAssertTrue(allColors.count == 4)
    }

    func testFamilyGenerationsEquals5() {
        let allGenerations = Locomotive.Generation.allCases
        XCTAssertTrue(allGenerations.count == 5)
    }

}
