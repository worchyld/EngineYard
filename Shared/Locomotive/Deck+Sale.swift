//
//  Deck+Sale.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Extending deck for Sale
extension Deck {

    // sell units
    func sell() {

        guard self.orderBook.existingOrders.count > 0 else {
            print ("\(self.name) has nothing to sell")
            return
        }

        let ownedCards = self.cards.filter { (c: Card) -> Bool in
            return ((c.owner != nil))
        }

        guard ownedCards.count > 0 else {
            print ("\(self.name) no units to sell")
            return
        }

    }

    private func analyse(units: Int, orders: [Int]) {
        let rule = SalesRule.init(orders)
        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            //self.handlePerfectMatch(tuple: match)
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
               // self.handleLowerMatch(tuple: match)
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                    //self.handleHigherMatch(tuple: match)
                }
            }
        }
    }
}
