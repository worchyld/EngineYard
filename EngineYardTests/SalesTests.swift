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

    func testLower() {
        let orders = [6]
        let units = 1

        let rule = SalesRules(orders)

        if let perfectMatch = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(perfectMatch.0) which is the value \(perfectMatch.1)")
        }
        else {
            if let lowerMatch = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(lowerMatch.0) which is the value \(lowerMatch.1)")
            }
            else {
                if let higherMatch = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(higherMatch.0)  which is the value \(higherMatch.1)")
                }
                else {
                    print ("No match found")
                }
            }
        } // end-if
    }

}
