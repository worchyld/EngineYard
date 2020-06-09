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
    var orders: [OrderCategory] = [OrderCategory]()

    enum OrderType: Int, CaseIterable {
        case existingOrder
        case completedOrder
    }

    enum OrderCategory {
        case existing(_ order: Int)
        case completed(_ order: Int)
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

    init(capacity: Int = 0) {
        self.capacity = capacity
    }
}

extension OrderBook {
    enum OrderBookError : Error {
        case ordersAreFull
        case unknownOrderType(type: OrderType)
    }

    func add(_ type: OrderType? = .existingOrder) throws  {
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }

        let value = Order.generate()

        switch type {
        case .existingOrder:
            let order = OrderCategory.existing(value)
            self.orders.append(order)
        case .completedOrder:
            let order = OrderCategory.completed(value)
            self.orders.append(order)

        case .none:
            throw OrderBookError.unknownOrderType(type: type!)
        }
    }

}

