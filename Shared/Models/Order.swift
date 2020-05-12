//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Order {
    let value: Int
    let state: OrderState

    init(value: Int, state: OrderState = .existingOrder) {
        self.value = value
        self.state = state
    }
}
