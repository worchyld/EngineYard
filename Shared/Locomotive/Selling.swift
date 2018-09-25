//
//  Selling.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// handles selling?

class Selling : NSObject {

    private var _decks: [Deck] = [Deck]()

    lazy var filtered = self._decks
        .filter { (d: Deck) -> Bool in
            return ((d.orderBook.existingOrders.count > 0) &&
                (d.orderBook.totalExistingOrders > 0) &&
                (d.owners?.count ?? 0 > 0) &&
                (d.active)
            )}
        .sorted(by: { (t1: Deck, t2: Deck) -> Bool in
            return (t1.cost < t2.cost)
        }
    )

    init(decks: [Deck]) {
        self._decks = decks
        super.init()
    }


    func salesLoop() {
        let decks = self.filtered.map{ $0.copy() as! Deck }

        for deck in decks {
            var condition = true
            while (condition == true) {

                for card in cardsWithProduction(deck: deck) {

                    let orders = deck.orderBook.existingOrderValues
                    let rule = SalesRule.init(orders)
                    let units = card.production.units

                    print (">> orders: \(orders), units: \(units)")

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

                    condition = true // #todo
                } // next


                // update condition
                condition = (
                    (cardsWithProduction(deck: deck).count > 0) &&
                    (deck.orderBook.existingOrders.count > 0)
                )
            }
        }
    }

    //
    // MARK: (Private) functions
    //

    private func cardsWithProduction(deck: Deck) -> [Card] {
        let results = deck.cards.filter({ (c: Card) -> Bool in
            return (c.production.units > 0)
        })
        return results
    }

    private func handlePerfectMatch(tuple: (Int, Int)) {
    }

    private func handleLowerMatch(tuple: (Int, Int)) {
    }

    private func handleHigherMatch(tuple: (Int, Int)) {
    }


}
