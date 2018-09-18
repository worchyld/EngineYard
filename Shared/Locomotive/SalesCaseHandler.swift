//
//  SalesCaseHandler.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class SalesCaseHandler {
    var units: Int
    var orders: [Int]

    init(_ units: Int, _ orders: [Int]) {
        self.units = units
        self.orders = orders
    }

    func analyse() {
        let rule = SalesRule.init(orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            self.handlePerfectMatch(tuple: match)
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                self.handleLowerMatch(tuple: match)
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                    self.handleHigherMatch(tuple: match)
                }
            }
        }
    }

    /*
     The player sells all the produced units and moves that die from the Existing Orders box to
     a Customer Base box for that type of locomotive. Then, he places the Production Unit
     counters above the locomotive card in question.
     */
    private func handlePerfectMatch(tuple: (Int, Int)) {
        self.orders[tuple.0] -= units
    }

    private func handleLowerMatch(tuple: (Int, Int)) {

    }

    private func handleHigherMatch(tuple: (Int, Int)) {

    }

}
