//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 06/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum MatchType : Equatable {
    case perfectMatch
    case lowerMatch
    case higherMatch
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


class SalesRuleHandler {

    private var orders: [Int]
    private var units: Int
    public private(set) var matchType: MatchType?
    public private(set) var matchTuple: (Int, Int)?

    init(orders: [Int], units: Int) {
        self.orders = orders
        self.units = units
        self.handler()
    }

    private func handler() {
        let rule = SalesRules(orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            self.matchType = MatchType.perfectMatch
            self.matchTuple = match
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                self.matchType = MatchType.lowerMatch
                self.matchTuple = match
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0)  which is the value \(match.1)")
                    self.matchType = MatchType.higherMatch
                    self.matchTuple = match
                }
            }
        } // end-if
    }

}
