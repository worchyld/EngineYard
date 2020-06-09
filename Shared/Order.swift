//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum IntError: Error {
    case cannotBeNegative
    case resultWillBeNegative
}

enum OrderError: Error {
    case canOnlyReduceValueOfExistingOrder
}

struct Order {
    enum State: Int, CaseIterable {
        case unowned, existingOrder, completedOrder
    }

    private (set) var value: Int
    var state: Order.State = .unowned

    init(_ state: Order.State = .existingOrder) {
        self.value = Die.roll
        self.state = state
    }
}

extension Order {
    mutating func setState(to state: Order.State) {        
        self.state = state
    }
    internal mutating func setValue(_ value: Int) throws {
        guard value >= 0 else {
            throw IntError.cannotBeNegative
        }
        self.value = value
    }
}

extension Order {
    mutating func reduceValue(by: Int) throws {
        guard self.value >= 0 else {
            throw IntError.cannotBeNegative
        }
        guard self.state == .existingOrder else {
            throw OrderError.canOnlyReduceValueOfExistingOrder
        }
        let sum = self.value
        guard (sum - by >= 0) else {
            throw IntError.resultWillBeNegative
        }
        self.value -= by
    }
}
