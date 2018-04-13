//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 17/02/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum OrderState {
    case existing
    case completed
}

class Order : EntryProtocol, CustomStringConvertible {
    public private(set) weak var parent: Deck?
    public private(set) var orderState: OrderState?
    var value: Int = 0
    var description: String {
        return String(self.value)
    }

    init(orderState: OrderState) {
        self.orderState = orderState
        self.value = Order.generate()
    }

    public static func generate() -> Int {
        return Die.roll()
    }

    func toggle(to orderState:OrderState) {
        if (orderState == .existing) {
            self.value = Order.generate()
        }
    }

}
