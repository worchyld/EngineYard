//
//  DeckTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

struct CardCounter : CustomStringConvertible {
    var green : Int = 0
    var blue : Int = 0
    var yellow : Int = 0
    var red : Int = 0

    struct Expected {
        static let green: Int = Meta.numberOfCards(with: .green)
        static let red: Int = Meta.numberOfCards(with: .red)
        static let blue: Int = Meta.numberOfCards(with: .blue)
        static let yellow: Int = Meta.numberOfCards(with: .yellow)
        static let totalCards: Int = Meta.totalCards
    }

    var total : Int {
        return (self.green + self.blue + self.yellow + self.red)
    }

    var description: String {
        return ("green: \(green) red: \(red) yellow:\(yellow) blue:\(blue)")
    }

    mutating func increment(with color: Deck.Color) {
        switch color {
        case .green:
            self.green += 1
            break

        case .red:
            self.red += 1
            break

        case .blue:
            self.blue += 1
            break

        case .yellow:
            self.yellow += 1
            break
        }
    }
}

class DeckTests: EngineYardTests {

    private var board: Board?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        board = nil
    }

    func testDecksCount() {
        guard let board = self.board else {
            XCTFail("No board created")
            return
        }

        XCTAssertTrue(board.decks.count == Meta.totalDecks)

        var counter = CardCounter()

        var totalCards: Int = 0

        for deck in board.decks {
            XCTAssertTrue(deck.cost % 4 == 0)
            XCTAssertTrue(deck.productionCost == Int(deck.cost / 2))
            XCTAssertTrue(deck.income == Int(deck.productionCost / 2))
            XCTAssertTrue(deck.orders.count == 0)

            totalCards += deck.cards.count

            for _ in deck.cards {
                counter.increment(with: deck.color)
            }
        }

        XCTAssertTrue(totalCards == CardCounter.Expected.totalCards, "\(totalCards). Expected: \(Meta.totalCards)")
        XCTAssertTrue(counter.red == CardCounter.Expected.red)
        XCTAssertTrue(counter.green == CardCounter.Expected.green)
        XCTAssertTrue(counter.yellow == CardCounter.Expected.yellow)
        XCTAssertTrue(counter.blue == CardCounter.Expected.blue)
    }

}
