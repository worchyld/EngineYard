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
    private(set) var value: Int?
    private(set) var state: Order.State = .unowned

    init(_ state: Order.State = .existingOrder) {
        self.value = Die.roll
        self.state = state
    }
}

extension Order {
    mutating func setState(state: Order.State) {
        self.state = state
    }
}
