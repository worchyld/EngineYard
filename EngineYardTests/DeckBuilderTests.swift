//
//  DeckBuilderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests against the `Deck` class

class DeckBuilderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testBuildDecksEquals14() {
        let decks = Deck.build()
        XCTAssertTrue(decks.count == Expected.totalDecksInGame)
    }

}
