//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum OrderType: Int {
    case existingOrder  // orders
    case completedOrder // customerBase
}

protocol EntryProtocol {
    var value: Int { get set }
}

final class OrderBook : NSObject {
    public private (set) weak var parent: Deck?
    public private (set) var orders: [Order] = [Order]()

    var hasMaximumDice: Bool {
        guard let hasParent: Deck = self.parent else {
            return false
        }
        let orderCount = self.existingOrders.count
        let salesCount = self.completedOrders.count
        let sum = (orderCount + salesCount)
        return (sum >= hasParent.capacity)
    }

    // Getters
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
    var existingOrderValues: [Int] {
        return self.existingOrders.compactMap({ (o:Order) -> Int in
            return o.value
        })

    }
    var completedOrderValues: [Int] {
        return self.completedOrders.compactMap({ (o:Order) -> Int in
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
        return ("OrderBook.existing = \(self.existingOrderValues), OrderBook.completedOrders = \(self.completedOrderValues)")
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
extension OrderBook {
    func rerollAndTransferCompletedOrders() {
        guard self.completedOrders.count > 0 else {
            return
        }
        for (_, item) in self.completedOrders.enumerated().reversed() {
            item.generate()
            item.transfer()
        }
    }

    //func transfer<C1: Any>(order: C1, index: Int) where C1: EntryProtocol {
    func transfer<C1: Any>(order: C1) where C1: EntryProtocol {
        if let orderObj = order as? Order {
            orderObj.transfer()
        }
    }
}

class Order : NSObject, EntryProtocol {
    weak var parent: OrderBook?
    public private (set) var orderType: OrderType?
    public internal (set) var value: Int = 0

    init(parent: OrderBook, orderType: OrderType) {
        super.init()
        self.parent = parent
        self.orderType = orderType
        self.generate()
    }

    func generate() {
        value = Die.roll()
    }

    func transfer() {
        guard let hasOrderType = self.orderType else {
            return
        }
        switch hasOrderType {
        case .existingOrder:
            self.orderType = OrderType.completedOrder
            break
        case .completedOrder:
            self.orderType = OrderType.existingOrder
            break
        }
    }
}
