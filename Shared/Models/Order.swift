//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

class Order {
    enum State: Int {
        case existing = 1
        case completed
    }

    let value: Int = 0
    private var _state: Order.State = .existing
    public var state: Order.State {
        return self._state
    }

}

extension Order : CustomStringConvertible {
    var description: String {
        return "Order: \(self.value) State: \(self.state.rawValue)"
    }
}

extension Order {
    func add(orderValue: Int = 0) -> Int {
        var value = orderValue
        if (value == 0) {
            return value
        }
        else {
            value = Die.roll()
        }
        return value
    }
}
