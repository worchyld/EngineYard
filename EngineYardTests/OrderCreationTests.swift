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

        // Needs replacing with a protocol conformance check
        guard let orderValue = order.value else {
            XCTFail("No order value")
            return
        }
        XCTAssertTrue(orderValue > 0 && orderValue < 7)
    }

    func testDidChangeOrderState() {
        var order = Order()
        XCTAssertTrue(order.state == .existingOrder)

        // Change the state to completed
        order.setState(state: .completedOrder)

        XCTAssertTrue(order.state == .completedOrder)
    }


}
