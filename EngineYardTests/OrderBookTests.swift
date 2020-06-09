//
//  OrderBookTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class OrderBookTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testOrderBookOrdersAreNil() {
        let orderBook = OrderBook.init(capacity: 3)
        XCTAssertNil(orderBook.orders)
    }

    func testOrderBookHasSingleOrder() {
        let orderBook = OrderBook.init(capacity: 3)
        XCTAssertNoThrow(
            try orderBook.add(.existingOrder)
        )
        XCTAssertNotNil(orderBook.orders)

        guard let orders = orderBook.orders else {
            XCTFail("Orders do not exist")
            return
        }

        XCTAssertTrue(orders.count == 1)
    }
    

}
