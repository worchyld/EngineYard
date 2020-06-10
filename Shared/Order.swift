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
    case resultWillBeNegative(value: Int)
}

enum OrderError: Error {
    case orderCannotBe(_ state: Order.State)
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
    mutating func reduceValue(by amount: Int) throws {
        guard (amount >= 0) else {
            throw IntError.cannotBeNegative
        }
        guard (self.state == .existingOrder) else {
            throw OrderError.orderCannotBe(self.state)
        }
        let sum = self.value
        guard (sum - amount >= 0) else {
            throw IntError.resultWillBeNegative(value: sum)
        }
        willReduceValue(by: amount)
    }

    private mutating func willReduceValue(by amount: Int) {
        self.value -= amount
    }
}
