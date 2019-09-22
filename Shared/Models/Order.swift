//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Order {
    enum State {
        case existing
        case completed
    }

    let value: Int
    let state: Order.State

    init(_ withValue: Int = 0) {
        self.state = .existing
        if (withValue > 0) {
            self.value = withValue
        }
        else {
            self.value = Die.roll()
        }
    }
}
