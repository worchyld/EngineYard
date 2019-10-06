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
}

extension Order : CustomStringConvertible {
    var description: String {
        return "Order: \(self.value) State: \(self.state.rawValue)"
    }
}

extension Order {
    func add(value: Int = 0) -> Int {
        return 0
    }

    
}
