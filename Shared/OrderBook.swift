//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum OrderBookError : Error {
    case ordersAreFull
    case unknownOrderState(_ state: Order.State?)
}

// A proxy-style pattern to add, remove orders to/from a deck
class OrderBook {
    let capacity: Int
    var orders: [Order]?

    init(capacity: Int, orders: [Order]? = nil) {
        self.capacity = capacity
        self.orders = orders
    }
}

extension OrderBook {
    var isFull : Bool {
        guard let hasOrders = self.orders else {
            return false
        }
        guard (hasOrders.count < capacity) else {
            return true
        }
        return false
    }
}
