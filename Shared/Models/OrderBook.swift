//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct OrderBook {
    let orders: [Order]

    init(orders: [Order]) {
        self.orders = orders
    }
}
