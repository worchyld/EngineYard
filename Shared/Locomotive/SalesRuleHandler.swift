//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 06/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum MatchType: Equatable {
    case perfectMatch(Int, Int)
    case lowerMatch(Int, Int)
    case higherMatch(Int, Int)
}

extension MatchType {
    static func == (lhs: MatchType, rhs: MatchType) -> Bool {
        switch (lhs, rhs) {
        case (.perfectMatch, .perfectMatch):
            return true
        case (.lowerMatch, .lowerMatch):
            return true
        case (.higherMatch, .higherMatch):
            return true
        default:
            return false
        }
    }
}


struct SalesRuleHandler {

    private var orders: [Int]
    private var units: Int
    public private(set) var matchType: MatchType?

    init(orders: [Int], units: Int) {
        self.orders = orders
        self.units = units
        self.matchType = self.handler()
    }

    private func handler() -> MatchType? {
        let rule = SalesRules(orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            return MatchType.perfectMatch(match.0, match.1)
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                return MatchType.lowerMatch(match.0, match.1)
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0)  which is the value \(match.1)")
                    return MatchType.higherMatch(match.0, match.1)
                }
            }
        } // end-if

        return nil
    }

}
