//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// OrderBook holds reference to orders and
//  manages the ability to add, move, remove orders

class OrderBook {
    private let capacity: Int
    var orders: [Order] = [Order]()

    init(capacity: Int) {
        self.capacity = capacity
    }

    /*
     The current number of dice for a locomotive type and generation
      is determined by the number of dice in the `Customer Base` (completedOrder) boxes
        added to any in the `Existing Orders` (existingOrder) boxes.
     */
    var isFull : Bool {
        guard (orders.count < capacity) else {
            return true
        }

        return false
    }


    enum OrderBookError : Error {
        case ordersAreFull
        case unknownOrderState(_ state: Order.State?)
    }


    func add(_ state: Order.State? = .existingOrder) throws  {
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }
        guard let hasState = state else {
            throw OrderBookError.unknownOrderState(state)
        }

        switch hasState {
        case .existingOrder:
            let order = Order.init(.existingOrder)
            self.orders.append(order)

        case .completedOrder:
            let order = Order.init(.completedOrder)
            self.orders.append(order)

        default:
            throw OrderBookError.unknownOrderState(hasState)
        }
    }

}

extension OrderBook : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("order: \(self.orders)")
    }
}
