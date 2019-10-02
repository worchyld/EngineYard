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

    let value: Int
    private var _state: Order.State
    public var state: Order.State {
        return self._state
    }

    init(_ withValue: Int = 0) {
        self._state = .existing
        if (withValue > 0) {
            self.value = withValue
        }
        else {
            self.value = Die.roll()
        }
    }
}

extension Order : CustomStringConvertible {
    var description: String {
        return "Order: \(self.value) State: \(self.state.rawValue)"
    }
}
