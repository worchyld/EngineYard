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

// OrderBook holds reference to orders and
//  manages the ability to add, move, remove orders

class OrderBook {
    private let capacity: Int
    var orders: [Order] = [Order]()

    init(capacity: Int) {
        self.capacity = capacity
    }
}

extension OrderBook {
    /*
     The current number of dice/orders for a locomotive type and generation
      is determined by the number of dice in the `Customer Base` (completedOrder) boxes
        added to any in the `Existing Orders` (existingOrder) boxes.
     */
    var isFull : Bool {
        guard (orders.count < capacity) else {
            return true
        }

        return false
    }

    // Add an order
    func add(_ state: Order.State? = .existingOrder) throws  {
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }
        guard let hasState = state else {
            throw OrderBookError.unknownOrderState(state)
        }

        if (hasState != .unowned) {
            let order = Order.init(hasState)
            self.orders.append(order)
        }
        else {
            throw OrderBookError.unknownOrderState(hasState)
        }
    }

    func clear() {
        self.orders.removeAll(keepingCapacity: true)
    }

    // convert the order to a state
    func transfer(order: Order, to: Order.State) {
        
    }
}

extension OrderBook : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("order: \(self.orders)")
    }
}
