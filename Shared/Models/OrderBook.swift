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

    func addOrder() {
        let order = Order()
        self.orders.append(order)
    }
}
