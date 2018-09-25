//
//  Selling.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol SalesRecordDelegate {
    func addSalesRecord(card: Card, units: Int, price: Int)
}

class Selling : CustomStringConvertible, SalesRecordDelegate {

    private var _decks: [Deck] = [Deck]()
    private var makeCopy: Bool = true
    lazy var delegate: SalesRecordDelegate = self

    var description: String {
        return ""
    }

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

    init(decks: [Deck], makeCopy: Bool = true) {
        self._decks = decks
        self.makeCopy = makeCopy
    }


    func salesLoop() {
        var decks: [Deck]

        if (self.makeCopy) {
            decks = self.filtered.map{ $0.copy() as! Deck }
        }
        else {
            decks = self.filtered
        }

        for deck in decks {

            var condition = true
            while (condition == true) {

                for card in cardsWithProduction(deck: deck) {

                    let orders = deck.orderBook.existingOrderValues
                    let rule = SalesRule.init(orders)
                    let units = card.production.units

                    print (">> orders: \(orders), units: \(units), spent: \(card.production.spentUnits)")

                    if let match = rule.perfectMatch(units) {
                        print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                        self.handlePerfectMatch(deck: deck, card: card, tuple: match)
                    }
                    else {
                        if let match = rule.lowerMatch(units) {
                            print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                            self.handleLowerMatch(deck: deck, card: card, tuple: match)
                        }
                        else {
                            if let match = rule.higherMatch(units) {
                                print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                                self.handleHigherMatch(deck: deck, card: card, tuple: match)
                            }
                        }
                    }


                    print (">> deck \(deck.description) <<")
                } // next


                // update condition
                condition = (
                    (cardsWithProduction(deck: deck).count > 0) &&
                        (deck.orderBook.existingOrders.count > 0)
                )

            } // wend

        } // next
    }

    //
    // MARK: Functions
    //

    func cardsWithProduction(deck: Deck) -> [Card] {
        let results = deck.cards.filter({ (c: Card) -> Bool in
            return (c.production.units > 0)
        })
        return results
    }

    func handlePerfectMatch(deck: Deck, card: Card, tuple: (Int, Int)) {
        let unitsSold = card.production.units
        do {
            try card.production.spend(unitsSold)

            delegate.addSalesRecord(card: card, units: unitsSold, price: card.income)

            deck.orderBook.reduceValueAt(index: tuple.0, byValue: unitsSold)
            print ("sold @ perfect match: \(unitsSold)")
        } catch let err {
            print (err.localizedDescription)
        }
    }

    func handleLowerMatch(deck: Deck, card: Card, tuple: (Int, Int)) {
        let unitsSold = card.production.units

        do {
            try card.production.spend(unitsSold)

            delegate.addSalesRecord(card: card, units: unitsSold, price: card.income)

            deck.orderBook.reduceValueAt(index: tuple.0, byValue: unitsSold)
            print ("sold @ lower match: \(unitsSold)")
        } catch let err {
            print (err.localizedDescription)
        }
    }

    func handleHigherMatch(deck: Deck, card: Card, tuple: (Int, Int)) {
        let unitsSold: Int = {
            return deck.orderBook.existingOrderValues[tuple.0] as Int
        }()

        do {
            try card.production.spend(unitsSold)

            var remainingUnits: Int = unitsSold
            remainingUnits -= unitsSold
            deck.orderBook.reduceValueAt(index: tuple.0, byValue: unitsSold)

            delegate.addSalesRecord(card: card, units: unitsSold, price: card.income)

            print ("sold @ higher match: \(unitsSold)")
        } catch let err {
            print (err.localizedDescription)
        }
    }

    // MARK: SalesRecordDelegate method

    func addSalesRecord(card: Card, units: Int, price: Int) {
        guard let hasOwner = card.owner else {
            return
        }
        let sale = Sale.init(productId: card.name, units: units, price: price)
        hasOwner.salesBook.add(sale: sale)
    }
    
}
