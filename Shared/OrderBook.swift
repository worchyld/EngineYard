//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum OrderBookError : Error {
    case undefinedOrderBook
    case orderCannotBe(_ state: Order.State)
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

extension OrderBook {
    private func initializeOrders() {
        self.orders = [Order]()
        self.orders?.reserveCapacity(capacity)
    }

    func add(_ orderState: Order.State = .existingOrder) throws {
        guard (orderState == .existingOrder || orderState == .completedOrder) else {
            throw OrderBookError.orderCannotBe(orderState)
        }
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }
        if (self.orders == nil) {
            initializeOrders()
        }
        let order: Order = Order(orderState)
        self.orders?.append(order)
    }
}
