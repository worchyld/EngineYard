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

final class OrderBook : NSObject, NSCopying {
    public private (set) weak var parent: Deck?
    private var orders: [Order] = [Order]()

    var hasMaximumDice: Bool {
        guard let hasParent: Deck = self.parent else {
            return false
        }
        let sum = self.totalOrders()
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
    var ordersOnBooks: Int {
        return (self.existingOrderValues.reduce(0, +))
    }

    // Init
    init(parent: Deck) {
        self.parent = parent
    }

    deinit {
        self.orders.removeAll()
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = OrderBook(parent: self.parent!)
        copy.orders = self.orders.map { $0.copy() as! Order }
        return copy
    }
}

extension OrderBook {
    override var description: String {
        return ("OrderBook: existing = \(self.existingOrderValues), completedOrders = \(self.completedOrderValues)")
    }
}

extension OrderBook {
    func add(_ orderType: OrderType, values: [Int]? =  nil) {
        if let values = values {
            // walk through each value
            let _ = values.map { (value: Int) -> Void in
                guard value > 0 else {
                    return
                }
                if (canAdd(orderType: orderType)) {
                    let order: Order = Order(parent: self, orderType: orderType, value: value)
                    self.orders.append( order )
                }
            }
        }
        else {
            // add a random value
            if (canAdd(orderType: orderType)) {
                let order: Order = Order(parent: self, orderType: orderType)
                self.orders.append( order )
            }
        }

    }

    internal func canAdd(orderType: OrderType) -> Bool {
        guard let hasParent = self.parent else {
            return false
        }
        guard (hasParent.rustedState != .obsolete) else {
            return false
        }
        guard (!self.hasMaximumDice) else {
            return false
        }
        return (self.orders.count < hasParent.capacity)
    }

    func fill(_ orderType: OrderType) {
        guard let hasParent = self.parent else {
            return
        }
        let total = totalOrders()
        if ((total < hasParent.capacity) && (!self.hasMaximumDice)) {
            let sum = hasParent.capacity - total
            for _ in 0...sum {
                self.add(orderType)
            }
        }
    }

    func reduceValueAt(index: Int, byValue: Int) {
        let result = self.orders[index] as Order
        result.value -= byValue
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

    // formely `removeAll`
    func clear() {
        self.orders.removeAll()
    }

    private func totalOrders() -> Int {
        let orderCount = self.existingOrders.count
        let salesCount = self.completedOrders.count
        return (orderCount + salesCount)
    }

    func transfer<C1: Any>(order: C1) where C1: EntryProtocol {
        if let orderObj = order as? Order {
            orderObj.transfer()
        }
    }

    // Remove first value from `completedOrder`
    // If no value is found; remove the lowest numbered value in orders
    // Handles: Transfer one of the dice from the Customer Base to the dice pool.
    // If no dice were in the `completedOrders`, the lowest numbered die in the `existingOrders` boxes is returned to the dice pool.
    func removeFirstCompletedOrder() {
        if (self.completedOrders.count > 0) {

            guard let unsortedElementsAndIndices = (self.orders
                .enumerated()
                .filter { (offset, element) -> Bool in
                    return (element.orderType == OrderType.existingOrder)
            }).first else {
                print ("no completed orders found")
                return
            }

            self.orders.remove(at: unsortedElementsAndIndices.offset)
        }
        else {

            guard let sortedElementsAndIndices = (self.existingOrders
                .enumerated()
                .filter { (offset, element) -> Bool in
                    return (element.orderType == OrderType.existingOrder)
                }
                .sorted(by: {
                    $0.element.value < $1.element.value
                }
                ).first)
            else {
                return
            }

            self.orders.remove(at: sortedElementsAndIndices.offset)
        }
    }

}

class Order : NSObject, NSCopying, EntryProtocol {
    weak var parent: OrderBook?
    public private (set) var orderType: OrderType?
    public internal (set) var value: Int = 0 {
        didSet {
            if (self.value < 0) {
                self.value = 0
            }
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Order(parent: self.parent!, orderType: self.orderType!, value: self.value)
        return copy
    }

    init(parent: OrderBook, orderType: OrderType, value: Int? = nil) {
        super.init()
        self.parent = parent
        self.orderType = orderType
        if let value = value {
            self.value = value
        }
        else {
            self.generate()
        }
    }

    func generate() {
        self.value = Die.roll()
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

    func reduce(by amount: Int) {
        guard amount > 0 else {
            return
        }
        guard amount <= self.value else {
            return
        }
        self.value -= amount
    }


}
