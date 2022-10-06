//
//  SalesOrderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 23/09/2022.
//

import XCTest

@testable import EngineYard

final class SalesOrderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSalesOrders() throws {
        let order = SalesOrder(orders: [2, 3, 5])
        let good = 8

        if let match = order.match(good) {
            print("Found match for: \(good) in \(order.orders) at index: \(match.0)")
        } else {
            print("No Match.. Checking Lower...")
            if let lower = order.lower(good) {
                print("Found lower for: \(good) in \(order.orders) at index: \(lower.0)")
            } else {
                print("No Lower.. Checking Higher...")
                if let higher = order.higher(good) {
                    print("Found higher for: \(good) in \(order.orders) at index: \(higher.0)")
                } else {
                    print("Failure.")
                }
            }
        }
    }
}
