//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 17/02/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum OrderType : Int {
    case existingOrder
    case completedOrder
}

class OrderBook {
    weak var parent: Deck?
    var orders: [Order] = [Order]()

    var existingOrders: [Order] {
        return self.orders.filter({
            return ($0.orderType == .existingOrder)
        })
    }
    var completedOrders: [Order] {
        return self.orders.filter({
            return ($0.orderType == .completedOrder)
        })
    }

    init(parent: Deck) {
        self.parent = parent
    }

    deinit {
        self.orders.removeAll()
    }

    // Add order
    func add(_ orderType: OrderType) {
        if (canAdd(orderType: orderType)) {
            let newOrder = Order.init(parent: self, orderType: orderType)
            self.orders.append(newOrder)
        }
    }

    internal func canAdd(orderType: OrderType) -> Bool {
        guard let hasParent = self.parent else {
            return false
        }
        return (self.orders.count < hasParent.capacity)
    }
}

class Order {
    weak var parent: OrderBook?
    var orderType: OrderType = .existingOrder
    var value: Int = 0

    init(parent: OrderBook, orderType: OrderType) {
        self.parent = parent
        self.orderType = orderType
        self.value = Die.roll()
        print ("Order generated: \(self.value)")
    }

    func decrement() {
        // can only decrement existingOrder types
        if (self.orderType == .existingOrder) {
            if (self.value > 0) {
                self.value -= 1
            }
            if (self.value == 0) {
                self.toggle(to: .completedOrder)
            }
        }
    }

    private func toggle(to orderType:OrderType) {
        self.orderType = orderType
    }
}
