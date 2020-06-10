//
//  Deck+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 10/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Filter functions for decks
extension Deck {

    static func filterOrders(in decks: [Deck?], matching needle: Family.Color) -> [Deck]? {
        guard let decks: [Deck] = decks as? [Deck] else {
            return nil
        }

        let filter = decks.filter { (deck: Deck) -> Bool in
            return (deck.color == needle && deck.orders.count > 0)
        }.sorted { (a: Deck, b: Deck) -> Bool in
            return ((a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue))
        }
        return filter
    }

    static func totalGenerations(in decks: [Deck]?) -> Int {
        guard let decks = decks else {
            return 0
        }
        let total = decks.reduce(0, {
            $0 + $1.generation.rawValue
        })
        return total
    }


    static func howManyGenerationsExist(in decks: [Deck?], matching needle: Family.Color) -> Int {
        guard let decks: [Deck] = decks as? [Deck] else {
            return 0
        }

        let filter = decks.filter { (deck) -> Bool in
            guard (deck.orders.count > 0) else {
                return false
            }
            return (deck.color == needle)
        }.reduce(0, {
            return ($0 + $1.generation.rawValue)
        })

        return filter
    }
}
