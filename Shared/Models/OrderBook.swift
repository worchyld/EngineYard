//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 06/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

class OrderBook {
    private weak var deck: Deck?
    public private (set) var orders: [Order] = [Order]()

    init(deck: Deck) {
        self.deck = deck
    }

    func add() {
        guard let deck = self.deck else {
            assertionFailure("No deck found")
            return
        }
        guard canAdd() else {
            return
        }
        deck.state = .active
        let order = Order()
        self.orders.append(order)
    }

    private func canAdd() -> Bool {
        guard let deck = self.deck else {
            assertionFailure("No deck found")
            return false
        }
        guard (deck.orders.count < deck.capacity) else {
            return false
        }
        return true
    }
}
