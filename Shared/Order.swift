//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum IntError: Error, Equatable {
    case cannotBeZero
    case cannotBeNegative
    case resultWillBeNegative(value: Int)
}

enum OrderError: Error, Equatable {
    case orderCannotBe(_ state: Order.State)
}

class Order: Identifiable {
    let id: UUID = UUID()

    enum State: Int, CaseIterable {
        case initialOrder, existingOrder, completedOrder
    }

    private (set) var value: Int
    private (set) var state: Order.State

    init(_ state: Order.State = .initialOrder) {
        self.value = Die.roll
        self.state = state
    }
}

extension Order: Equatable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension Order {
    func setState(to state: Order.State) {
        self.state = state
    }
    func setValue(_ value: Int) throws {
        guard value >= 0 else {
            throw IntError.cannotBeNegative
        }
        self.value = value
    }
}

extension Order {
    // Only existing orders can be reduced in value
    func reduceValue(by amount: Int) throws {
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

    private func willReduceValue(by amount: Int) {
        self.value -= amount
    }
}

extension Order : CustomStringConvertible {
    var description: String {
        return "value: \(self.value), state: \(self.state)"
    }
}
