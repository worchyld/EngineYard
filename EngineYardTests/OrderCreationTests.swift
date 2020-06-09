//
//  OrderCreationTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderCreationTests: XCTestCase {

    var board: Board?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        self.board = EngineYardGame.loadInitialBoard()
    }

    func testDidCreateSingleExistingOrder() {
        let order = Order()
        XCTAssertNotNil(order.value)
        XCTAssertTrue(order.state.rawValue == Order.State.existingOrder.rawValue)
    }

    func testCanAddExistingOrderToFirstDeck() {
        guard let board = self.board else {
            XCTFail("No board defined")
            return
        }
        guard let firstDeck = board.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertNotNil(firstDeck)
        XCTAssertNil(firstDeck?.orders)

        
    }

}
