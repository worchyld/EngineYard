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

    private func cardsWithProduction(deck: Deck) -> [Card] {
        let results = deck.cards.filter({ (c: Card) -> Bool in
            return (c.production.units > 0)
        })
        return results
    }

    func salesLoop() {

        let decks = self.filtered.map{ $0.copy() as! Deck }

        for deck in decks {
            var condition = true
            while (condition == true) {

                print (deck.description)

                for card in cardsWithProduction(deck: deck) {
                    print (card.description)
                }

                let salesRuleObj = SalesRule.init(deck.orderBook.existingOrderValues)


                // update condition
                condition = (
                    (cardsWithProduction(deck: deck).count > 0) &&
                    (deck.orderBook.existingOrders.count > 0)
                )
            }
        }
    }
}
