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
    var orders: [OrderType] = [OrderType]()

    enum OrderType {
        case existing(_ orders: [Int])
        case completed(_ orders: [Int])
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

    func add(orderType: OrderType) {
        self.orders.append(orderType)
    }
}

