//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 05/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum SalesRuleMatchType
{
    case perfectMatch
    case lowerMatch
    case higherMatch
}

struct SalesRuleHandler {
    public private(set) var orders: [Int]
    public private(set) var units: Int
    public private(set) var rules: SalesRules

    init(orders: [Int], units: Int) {
        self.orders = orders
        self.units = units
        self.rules = SalesRules(self.orders)
    }

    func handler() -> (Int, Int)? {

        if let match = self.isPerfectMatch() {
        }
        else {
            if let match = self.rules.lowerMatch(units) {
                print("Found LOWER match for: \(units) in orders \(orders) at index: \(match.0) which is the value \(match.1)")
                return SalesRuleMatchType.lowerMatch
            }
            else {
                if let match = self.rules.higherMatch(units) {
                    print("Found HIGHER match for: \(units) in orders \(orders) at index: \(match.0)  which is the value \(match.1)")
                    return SalesRuleMatchType.higherMatch
                }
                else {
                    print ("No match found")
                    return nil
                }
            }
        } // end-if


    }

    private func isPerfectMatch() -> SalesRuleMatchType? {
        if let match = self.rules.perfectMatch(units) {
            print("Found PERFECT match for: \(units) in orders \(orders) at index: \(match.0) which is the value \(match.1)")

            return SalesRuleMatchType.perfectMatch
        }
        else {
            return nil
        }
    }

}
