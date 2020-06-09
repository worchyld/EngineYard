//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Each deck has `orders` and `sales`
// Both are represented by Int/Dice values in
//    a single array
struct Order {
    enum State: Int {
        case unowned
        case existingOrder   // Defined by manual as `existingOrders`
        case completedOrder  // Defined by manual as `customerBase`
    }
    var value: Int?
    var state: Order.State = .unowned

    init(_ state: Order.State = .existingOrder) {
        self.value = self.generate()
        self.state = state
    }
}

extension Order {
    func generate() -> Int {
        return Die.roll
    }
}
