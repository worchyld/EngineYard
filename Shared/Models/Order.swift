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

    public private (set) var value: Int = 0
    public private (set) var state: Order.State = .existing

    init() {
        self.value = Order.generate()
        self.state = .existing
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
        case .existing:
            // move: existingOrder -> completedOrder
            self.state = .completed
        break

        case .completed:
             // move: completedOrder -> existingOrder
            self.state = .existing
        break
        }
    }

    private func didTransfer() {

    }

}
