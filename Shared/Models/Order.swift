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
        case existingOrder = 0
        case completedOrder
    }

    public private (set) var value: Int = 0
    public private (set) var state: Order.State = .existingOrder

    init(state: Order.State = .existingOrder, value: Int = 0) {
        if (value == 0) {
            self.value = Order.generate()
        }
        else {
            self.value = value
        }
        self.state = state
    }
}

extension Order : CustomStringConvertible {
    var description: String {
        return "Order: \(self.value) State: \(self.state.rawValue)"
    }
}

extension Order {
    public static func generate() -> Int {
        return Die.roll()
    }

    func transfer() {
        switch self.state {
        case .existingOrder:
            // move: existingOrder -> completedOrder
            self.state = .completedOrder
        break

        case .completedOrder:
             // move: completedOrder -> existingOrder
            self.state = .existingOrder
        break
        }
    }

    private func didTransfer() {

    }

}
