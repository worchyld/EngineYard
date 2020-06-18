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
    case noOrdersFoundWithState(_ state: Order.State)
    case unknownOrderState(_ state: Order.State?)
    case alreadyHasInitialOrder
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
    func filter(on state: Order.State) -> [Order]? {
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
        self.push(order: order)
    }
}

extension OrderBook {
    private func push(order: Order) {
        self.orders.append(order)
    }

    private func pop(order: Order, at index: Int) {
        self.orders.remove(at: index)
    }
}

extension OrderBook {

    // transfer an order from one state to another
    func transfer(order: Order, to state: Order.State) throws {
        guard (state == .existingOrder || state == .completedOrder) else {
            throw OrderError.orderCannotBe(state)
        }
        order.setState(to: state)
    }

    func transfer(orders: [Order], to state: Order.State) throws {
        do {
            for order in orders {
                //var order = order
                try transfer(order: order, to: state)
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
            guard (order.state == .existingOrder) else {
                throw OrderBookError.noOrdersFoundWithState(.existingOrder)
            }

            let _ = try order.decreaseValue(by: amount)
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
        do {
            guard let filter = self.filter(on: .completedOrder) else {
                throw OrderBookError.noOrdersFoundWithState(.completedOrder)
            }
            if (filter.isEmpty || filter.count == 0) {
                throw OrderBookError.noOrdersFoundWithState(.completedOrder)
            }

            let _ = try filter.forEach { (order: Order) in
                print ("current value -- \(order.value)")
                let value = Die.roll
                try order.setValue(value)
                print (".. new value -- \(order.value)")
            }
        } catch {
            throw error
        }
    }
}

extension OrderBook {
    func transferCompletedOrdersToExisting() throws {
        guard let filter = self.filter(on: .completedOrder) else {
            throw OrderBookError.noOrdersFoundWithState(.completedOrder)
        }
        guard (filter.count > 0) else {
            throw OrderBookError.noOrdersFoundWithState(.completedOrder)
        }
        do {
            let _ = try filter.map { try transfer(order: $0, to: .existingOrder)  }
        }
        catch {
            throw error
        }
    }
}

extension OrderBook {
    private func checkForInitialOrders() throws {
        let filter = self.filter(on: .initialOrder)

        if (filter != nil) {
            guard let initialOrders = filter else {
                return
            }
            if ((initialOrders.count > 0) && (!initialOrders.isEmpty)) {
                throw OrderBookError.alreadyHasInitialOrder
            }
        }
    }
}

// MARK: PRUNE functions

extension OrderBook {
    // Remove 1 order from salesPool if exist
    // If no orders exist, remove from existingOrders
    internal func getOrdersToPrune() -> [Order]? {
        var ordersToPrune = [Order]()

        // Can't prune if it has `initalOrder`
        if let initialOrders = self.filter(on: .initialOrder) {
            guard (initialOrders.count == 0) else {
                return nil
            }
        }

        // Find `completedOrders`
        if let completedOrders = self.filter(on: .completedOrder) {
            ordersToPrune = completedOrders
        }

        if (ordersToPrune.count == 0) {
            // Find `existingOrders`
            guard let existingOrders = self.filter(on: .existingOrder) else {
                return nil
            }
            guard (existingOrders.count > 0) else {
                return nil
            }

            ordersToPrune = existingOrders
        }

        return ordersToPrune
    }

    internal func pruneSingleOrder() {
        guard let ordersToPrune = self.getOrdersToPrune() else {
            return
        }

        guard (ordersToPrune.count > 0) else {
            return
        }

        guard let firstOrderToPrune = ordersToPrune.first else {
            return
        }

        guard let index = self.orders.firstIndex(of: firstOrderToPrune) else {
            return
        }

        self.pop(order: firstOrderToPrune, at: index)
    }
}
