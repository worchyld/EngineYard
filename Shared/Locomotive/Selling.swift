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

struct SellingRound : SalesProtocol {
    var detail: String?
    var player: Player?
    var deck: Deck?
    var card: Card?
    var units: Int = 0
    var price: Int = 0
    var total: Int {
        guard (units > 0 && price > 0) else {
            return 0
        }
        return (units * price)
    }
}

class Selling : NSObject {
    private weak var game: Game?

    var round : [SellingRound]  = [SellingRound]()


    init(game: Game) {
        self.game = game
    }

    func beginSelling() {
        guard let hasGame = self.game else {
            assertionFailure("No game object found")
            return
        }

        let filtered = Board.filterDecksWithExistingOrders(decks: hasGame.board.decks)
        print (filtered)

        for deck in filtered {
            print ("selling from deck: \(deck.name)")
        }
        
    }
}

/*
class Selling : CustomStringConvertible, SalesRecordDelegate {

    private var _decks: [Deck] = [Deck]()
    lazy var delegate: SalesRecordDelegate = self

    var description: String {
        return ""
    }

    init(board: Board, makeCopy: Bool = true) {
        self._decks = board.decks
    }


    func salesLoop() {
        let filtered = Board.filterDecksWithExistingOrders(decks: self._decks)

        for deck in filtered {

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
            print ("\(#function) has no owner")
            return
        }
        let sale = Sale.init(productId: card.name, units: units, price: price)
        hasOwner.salesBook.add(sale: sale)
        print ("added sale: \(sale.description) to \(String(describing: hasOwner.name)) salesbook --> \(hasOwner.salesBook.sales.count)")
    }
    
}
*/
