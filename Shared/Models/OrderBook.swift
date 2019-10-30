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

    var existingOrders: [Order] {
        return self.orders.filter({
            return ($0.state == .existingOrder)
        })
    }
    var completedOrders: [Order] {
        return self.orders.filter({
            return ($0.state == .completedOrder)
        })
    }


    init(deck: Deck) {
        self.deck = deck
    }

    deinit {
        self.orders.removeAll()
    }

    func add() {
        guard let deck = self.deck else {
            return
        }
        guard canAdd() else {
            return
        }
        deck.activate()
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

extension OrderBook {
    func transfer() {
        // #TODO
    }

    func rerollAndTransfer() {
        // #TODO
    }

    func reduceExistingOrderValueAtIndex(index:Int, byValue:Int) -> Int? {
         // #TODO
        return nil
    }

    // Remove first value from completedOrder
    // If no value is found; remove the lowest numbered value in orders
    func removeFirstValueFromCompletedOrder() {
        // #TODO
    }
}
