//
//  CardFilterTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class CardFilterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFilteredCards() {
        let cards = Card.build()
        let expected = Expected(color: .green, generation: nil)
        let filtered = Card.filter(cards: cards, matching: (color: .green, generation: nil))
        XCTAssertTrue(filtered.count == expected.results)

    }
}
