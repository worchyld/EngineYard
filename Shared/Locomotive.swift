//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of `Locomotives`; each with cards
class Locomotive: Identifiable {
    let id: UUID = UUID()
    let name: String
    let group: LocomotiveGroup
    let cost: Int
    var cards: [Card] = [Card]()

    lazy var formattedCost: String? = {
        let cache = NumberFormatCache.currencyRateFormatter
        let number = NSNumber(integerLiteral: self.cost)
        return cache.string(from: number)
    }()

    // Orders ------------- //
    let orderCapacity: Int
    private (set) var orders: [Order] = [Order]()

    lazy var existingOrders: [Order] = {
        return self.orders.filter { (o: Order) -> Bool in
            return o.state == .existingOrder
        }
    }()
    lazy var completedOrders: [Order] = {
        return self.orders.filter { (o: Order) -> Bool in
            return o.state == .completedOrder
        }
    }()
    lazy var initialOrder: Order? = {
        return self.orders.filter { (o: Order) -> Bool in
            return o.state == .initialOrder
        }.first
    }()
    // -------------------- //

    enum State: Int, CaseIterable {
       case unavailable, existing, old, obsolete
    }
    var state: Locomotive.State = Locomotive.State.unavailable

    init(_ name: String, _ cost: Int, _ color: Locomotive.Color, _ generation: Locomotive.Generation, _ orderCapacity: Int) {
        self.name = name
        self.cost = cost
        self.group = LocomotiveGroup(color: color, generation: generation)
        self.orderCapacity = orderCapacity
        self.orders.reserveCapacity(orderCapacity)
        //self.orders = Array<Order?>(repeating: nil, count: orderCapacity)
    }
}

extension Locomotive : CustomStringConvertible {
    var description: String {
        var outputtedCost = "NaN"
        if let formattedCost = formattedCost {
            outputtedCost = formattedCost
        }
        return ("\(name), \(outputtedCost), \(group), orders: \(orders)")
    }
}

extension Locomotive: LocomotiveGroupDelegate {
    var color: Locomotive.Color { return self.group.color }
    var generation: Locomotive.Generation { return self.group.generation }
}

extension Locomotive: Equatable {
    static func == (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension Locomotive {
    private func changeState(to: Locomotive.State) {
        self.state = to
    }
}

extension Locomotive: UpdateOrdersDelegate {
    internal func updateOrders(from book: OrderBook) {
        guard ((!book.isEmpty) && (book.orders.count > 0 && book.orders.count <= self.orderCapacity)) else {
            return
        }
        self.orders = book.orders
    }
}
