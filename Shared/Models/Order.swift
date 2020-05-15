//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// A deck has an array of "orders" which can either be existingOrder, sold
// with a Int value
class Order {
    enum State: Int, CaseIterable {
        case existingOrder = 0
        case sold

        static let allRawValues = Order.State.existingOrder.rawValue...Order.State.sold.rawValue
    }

    let value: Int
    var state: Order.State

    init(value: Int, state: Order.State = .existingOrder) {
        self.value = value
        self.state = state
    }
}
