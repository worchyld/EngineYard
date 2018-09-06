//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 06/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum SalesMatchType: Int {
    case perfectMatch
    case lowerMatch
    case higherMatch
}

class SalesMatch {
    var type: SalesMatchType? // perfectMatch, etc
    var tuple: (Int, Int)?

    init(type: SalesMatchType, tuple: (Int, Int)) {
        self.type = type
        self.tuple = tuple
    }
}

class SalesRuleHandler {
    var orders: [Int]
    var units: Int
    private var _matchObj: SalesMatch?
    var matchObj: SalesMatch? {
        return self._matchObj
    }

    init(orders: [Int], units: Int) {
        self.orders = orders
        self.units = units
        self._matchObj = self.handler()
    }

    private func handler() -> SalesMatch? {

        let rule = SalesRule(self.orders)

        if let match = rule.perfectMatch(self.units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")

            return SalesMatch(type: .perfectMatch, tuple: match)
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")

                return SalesMatch(type: .lowerMatch, tuple: match)
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")

                    return SalesMatch(type: .higherMatch, tuple: match)
                }
            }
        }

        return nil
    }
}

