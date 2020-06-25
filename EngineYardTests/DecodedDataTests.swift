//
//  MetaTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class DecodedDataTests: XCTestCase {

    var response: Response!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        let resourceFile = Constants.boardJSONFile

        do {
            let response = try bundle.decode(Response.self, from: resourceFile)
            self.response = response
        }
        catch {
            throw error
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {

        XCTAssertNotNil(response.meta)
        XCTAssertNotNil(response.factories)
        XCTAssertNotNil(response.cards)

        // Test against meta
        guard let meta = response.meta else {
            XCTFail("No meta found")
            return
        }

        XCTAssertEqual( meta.factories,  14 )
        XCTAssertEqual( meta.totalCapacity,  46 )
        XCTAssertEqual( meta.cards.total, 43 )

        example(of: "Expecting 20 green", {
            let expected = 20
            XCTAssertEqual( meta.cards.green.total, expected )
            XCTAssertEqual( meta.cards.green.generations.count, 5 )
            XCTAssertEqual( meta.cards.green.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.green.generations.reduce(0, +) , meta.cards.green.total)
        })


        example(of: "Expecting 13 red", {
            let expected = 13
            XCTAssertEqual( meta.cards.red.total, 13 )
            XCTAssertEqual( meta.cards.red.generations.count, 5 )
            XCTAssertEqual( meta.cards.red.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.red.generations.reduce(0, +) , meta.cards.red.total)
        })

        example(of: "Expecting 7 yellow", {
            let expected = 7
            XCTAssertEqual( meta.cards.yellow.total, 7 )
            XCTAssertEqual( meta.cards.yellow.generations.count, 5 )
            XCTAssertEqual( meta.cards.yellow.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.yellow.generations.reduce(0, +) , meta.cards.yellow.total)
        })

        example(of: "Expecting 3 blue", {
            let expected = 3
            XCTAssertEqual( meta.cards.blue.total, 3 )
            XCTAssertEqual( meta.cards.blue.generations.count, 5 )
            XCTAssertEqual( meta.cards.blue.generations.reduce(0, +) , expected)
            XCTAssertEqual( meta.cards.blue.generations.reduce(0, +) , meta.cards.blue.total)
        })

    }

    func testFactoriesEqualsSpaces() throws {
        guard let factories = response.factories else {
            throw NSError(domain: "No factories found", code: 0, userInfo: nil)
        }
        XCTAssertEqual(factories.count, response.meta?.factories)
    }

    func testCards() throws -> [Card] {
        guard let cards = response.cards else {
            throw NSError(domain: "No cards found", code: 0, userInfo: nil)
        }
        return cards
    }

    func testLocomotivesEqualsCardsQty() throws {
        let cards = try testCards()
        XCTAssertEqual(cards.count, response.meta?.cards.total)
    }

    func testFilterGreenCards() throws {
        let cards = try testCards()
        let expected = 20
        let green = Card.filter(cards: cards, on: .green)
        XCTAssertEqual(green.count, response.meta?.cards.green.total)
        XCTAssertEqual(green.count, expected)
    }

    func testFilterRedCards() throws {
        let cards = try testCards()
        let expected = 13
        let red = Card.filter(cards: cards, on: .red)
        XCTAssertEqual(red.count, response.meta?.cards.red.total)
        XCTAssertEqual(red.count, expected)
    }

    func testFilterYellowCards() throws {
        let cards = try testCards()
        let expected = 7
        let yellow = Card.filter(cards: cards, on: .yellow)
        print ("yellow cards == \(yellow as Any)")
        XCTAssertEqual(yellow.count, response.meta?.cards.yellow.total)
        XCTAssertEqual(yellow.count, expected)
    }

    func testFilterBlueCards() throws {
        let cards = try testCards()
        let expected = 3
        let blue = Card.filter(cards: cards, on: .blue)
        XCTAssertEqual(blue.count, response.meta?.cards.blue.total)
        XCTAssertEqual(blue.count, expected)
    }

    func testCardTotals() throws {
        let cards = try testCards()

        let green =  Card.filter(cards: cards, on: .green).count
        let yellow = Card.filter(cards: cards, on: .yellow).count
        let red = Card.filter(cards: cards, on: .red).count
        let blue =  Card.filter(cards: cards, on: .blue).count

        let total = green + yellow + red + blue
        XCTAssertEqual( total, response.meta?.cards.total )
    }

    func testCapacities() throws {
        guard let factories = response.factories else {
            XCTFail("No factories found")
            return
        }

        let totalCapacity = factories.reduce(0, { $0 + $1.orderCapacity }  )
        XCTAssertEqual(totalCapacity, response.meta?.totalCapacity)
    }


}
