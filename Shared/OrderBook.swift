//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum OrderType: Int {
    case existingOrder
    case customerBase  // completedOrder
}

class OrderBook : NSObject {
    public private (set) weak var parent: Deck?
    public private (set) var orders: [Order] = [Order]()

    // Getters
    var existingOrders: [Order] {
        return self.orders.filter({
            return ($0.orderType == .existingOrder)
        })
    }
    var customerBase: [Order] {
        return self.orders.filter({
            return ($0.orderType == .customerBase)
        })
    }
    var existingOrderValues: [Int] {
        return self.existingOrders.compactMap({ (o:Order) -> Int in
            return o.value
        })

    }
    var customerBaseValues: [Int] {
        return self.customerBase.compactMap({ (o:Order) -> Int in
            return o.value
        })
    }

    // Init
    init(parent: Deck) {
        self.parent = parent
    }

    deinit {
        self.orders.removeAll()
    }
}

extension OrderBook {
    override var description: String {
        return ("OrderBook.existing = \(self.existingOrderValues), OrderBook.customerBase = \(self.customerBaseValues)")
    }
}

extension OrderBook {
    func add(_ orderType: OrderType) {
        if (canAdd(orderType: orderType)) {
            let newOrder = Order.init(parent: self, orderType: orderType)
            self.orders.append(newOrder)
        }
    }

    internal func canAdd(orderType: OrderType) -> Bool {
        guard let hasParent = self.parent else {
            NSLog("No space")
            return false
        }
        return (self.orders.count < hasParent.capacity)
    }
}

class Order : NSObject {
    weak var parent: OrderBook?
    public private (set) var orderType: OrderType?
    public private (set) var value: Int = 0

    init(parent: OrderBook, orderType: OrderType) {
        self.parent = parent
        self.orderType = orderType
        self.value = Die.roll()
    }

}
