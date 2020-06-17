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
    case noOrdersFound
    case noOrdersWithState(_ state: Order.State)
    case unknownOrderState(_ state: Order.State?)
    case alreadyHasInitialOrders(orders: [Order]?)
}

protocol UpdateOrdersDelegate: AnyObject {
    func updateLocomotiveOrders(from book: OrderBook)
}

// A proxy-style pattern to add, remove orders to/from a locomotive
class OrderBook {
    private weak var delegate: UpdateOrdersDelegate?

    private let capacity: Int
    private (set) var orders: [Order] = [Order]()

    public var isEmpty: Bool {
        return self.orders.isEmpty
    }
    public var count: Int {
        return self.orders.count
    }

    init(with locomotive: Locomotive) {
        self.capacity = locomotive.orderCapacity
        self.orders = locomotive.orders
        self.delegate = locomotive
    }

    // Orders can be overridden to check against capacity & other rules
    init(capacity: Int, orders: [Order]? = nil) {
        self.capacity = capacity
        if let orders = orders {
            guard (!orders.isEmpty) else {
                return
            }
            guard ((orders.count > 0) && (orders.count <= self.capacity)) else {
                return
            }
            self.orders = orders
        }
    }

    func setDelegate(delegate: UpdateOrdersDelegate) {
        self.delegate = delegate
    }
}

extension OrderBook {
    var isFull : Bool {
        guard (orders.count >= capacity) else {
            return false
        }
        return true
    }
}

extension OrderBook {
    func filterOrders(for state: Order.State) -> [Order]? {
        return self.orders.filter({ return $0.state == state })
    }
}

extension OrderBook {
    func updateOrders() {
        self.delegate?.updateLocomotiveOrders(from: self)
    }
}

extension OrderBook {

    // add an order
    func add(_ orderState: Order.State = .existingOrder) throws {
        guard !isFull else {
            throw OrderBookError.ordersAreFull
        }
        
        if (orderState == .initialOrder) {
            do {
                try checkForInitialOrders()
            }
            catch {
                throw error
            }
        }


        let order: Order = Order(orderState)
        self.orders.append(order)
    }
}

extension OrderBook {

    // transfer an order from one state to another
    func transfer(order: Order, to state: Order.State) throws -> Order {
        guard (state == .existingOrder || state == .completedOrder) else {
            throw OrderError.orderCannotBe(state)
        }
        order.setState(to: state)
        return order
    }

    func transfer(orders: [Order], to state: Order.State) throws {
        do {
            for order in orders {
                var order = order
                order = try transfer(order: order, to: state)
            }
        } catch {
            throw error
        }
    }
}

extension OrderBook {

    // Decrease an order by a value
    func decrease(order: Order, by amount: Int) throws {
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

extension OrderBook {

    // Can only re-roll completed orders
    func rerollCompletedOrders() throws {

        guard (!orders.isEmpty && orders.count > 0) else {
            throw OrderBookError.noOrdersFound            
        }
        let filter = orders
            .filter { $0.state == .completedOrder }
        if (filter.isEmpty || filter.count == 0) {
            throw OrderBookError.noOrdersWithState(.completedOrder)
        }

        do {
             let _ = try filter.forEach { (order: Order) in
                print ("current value -- \(order.value)")
                let value = Die.roll
                print ("rolled die -- \(value)")
                try order.setValue(value)
            }
        } catch {
            throw error
        }

    }
}

extension OrderBook {
    private func checkForInitialOrders() throws {
        let filter = self.filterOrders(for: .initialOrder)

        if (filter != nil) {
            guard let initialOrders = filter else {
                return
            }
            if ((initialOrders.count > 0) && (!initialOrders.isEmpty)) {
                throw OrderBookError.alreadyHasInitialOrders(orders: initialOrders)
            }
        }
    }
}
