//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum OrderBookError : Error, Equatable {
    case undefinedOrderBook
    case ordersAreFull
    case unknownOrderState(_ state: Order.State?)
    case alreadyHasInitialOrders(orders: [Order]?)
}

// A proxy-style pattern to add, remove orders to/from a locomotive
class OrderBook {
    let capacity: Int
    var orders: [Order]?

    init(capacity: Int, orders: [Order]? = nil) {
        self.capacity = capacity
        if (orders == nil) {
            self.orders = [Order]()
            self.orders?.reserveCapacity(capacity)
        }
        else {
            self.orders = orders
        }
    }
}

extension OrderBook {
    var isFull : Bool {
        guard let hasOrders = self.orders else {
            return false
        }
        guard (hasOrders.count < capacity) else {
            return true
        }
        return false
    }
}

extension OrderBook {

    // add an order
    func add(_ orderState: Order.State = .existingOrder) throws {
//        guard (orderState == .existingOrder || orderState == .completedOrder) else {
//            throw OrderError.orderCannotBe(orderState)
//        }
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }
        if (orderState == .initialOrder) {
            let initialOrders = self.orders?.filter({ (o: Order) -> Bool in
                return o.state == .initialOrder
                })

            if (initialOrders != nil) {
                guard let initialOrders = initialOrders else {
                    return
                }
                print (initialOrders)
                throw OrderBookError.alreadyHasInitialOrders(orders: initialOrders)
            }
        }

        let order: Order = Order(orderState)
        self.orders?.append(order)
    }

    // transfer an order from one state to another
    func transfer(order: inout Order, to state: Order.State) throws {
        guard (state == .existingOrder || state == .completedOrder) else {
            throw OrderError.orderCannotBe(state)
        }

        order.setState(to: state)
    }

    // Reduce an order by a value
    func reduce(order: inout Order, by amount: Int) throws {
        do {
            let _ = try order.reduceValue(by: amount)
            if (order.value == 0) {
                try order.setValue(1)
            }
        }
        catch {
            throw error
        }
    }
}
