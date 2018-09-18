//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 05/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard


class SalesTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerfectMatch() {
        let units = 3
        let orders = [3]

        let handler = SalesCaseHandler(units, orders)
        handler.analyse()

        print (handler.units)
        print (handler.orders)

        /*
        let rule = SalesRule(orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                }
            }
        }
         */
    }


}
