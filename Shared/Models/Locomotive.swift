//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

class Locomotive : Identifiable, Codable {
    let id: UUID
    let name: String
    let livery: Livery
    let generation: Generation
    let cost: Int
    var productionCost: Int {
        return Int(round(Double(self.cost) / 2))
    }
    var income: Int {
        return Int(round(Double(self.productionCost) / 2))
    }
    let capacity: Int // for dice
    var qty: Int // how many exist
    var rust: Rust
    var orders: [Int]
    var sales: [Int]
    
    var isFull: Bool {
        if ((orders.count + sales.count) == capacity) {
            return true
        }
        return false
    }
    var isAvailable: Bool {
        let hasOrders = orders.count >= 0
        let hasSales = sales.count >= 0
        return ((hasOrders || hasSales) && rust.isActiveButNotRusted())
    }
    
    init(id: UUID, name: String, livery: Livery, generation: Generation, cost: Int, qty: Int, capacity: Int, rust: Rust?, orders: [Int]?, sales: [Int]?) {
        self.id = id
        self.name = name
        self.livery = livery
        self.generation = generation
        self.cost = cost
        self.qty = qty
        self.capacity = capacity
        if let rust = rust {
            self.rust = rust
        } else {
            self.rust = .notBuilt
        }
        if let orders = orders {
            self.orders = orders
        } else {
            self.orders = [Int]()
        }
        if let sales = sales {
            self.sales = sales
        } else {
            self.sales = [Int]()
        }
    }

}

extension Locomotive {
    func reduceQtyBy1() {
        guard qty > 0 else { return }
        qty -= 1
    }
    func rustify() {
        self.rust.rustify()
    }
    func addOrder(order: Int) {
        guard (!self.isFull) else { return }
        guard (order.isD6) else { return }
        if ((self.rust == .notBuilt) && (self.orders.count == 0)) { self.rustify() }
        self.orders.append(order)
    }
    func addSale(order: Int) {
        guard (!self.isFull) else { return }
        guard (order.isD6) else { return }
        self.sales.append(order)
    }
}

extension Locomotive : Equatable {
    static func == (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.id == rhs.id)
    }
    static func isHigherGeneration(lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation > rhs.generation)
    }
    static func isLowerGeneration(lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation < rhs.generation)
    }
}

extension Locomotive : CustomDebugStringConvertible {
    var debugDescription: String {
        return "Locomotive: \(self.name), Livery: \(self.livery), Generation: \(self.generation), $\(self.cost), Qty: \(self.qty), Capacity: \(self.capacity), Rust: \(self.rust)"
    }
}


extension Locomotive {
    internal static func allLocos() -> [Locomotive] {
        let locos: [Locomotive] = [
            Locomotive.init(id: UUID(), name: "General I", livery: .green, generation: .first, cost: 4, qty: 4, capacity: 3, rust: nil, orders: nil, sales:nil),
            Locomotive.init(id: UUID(), name: "Fast Freight I", livery: .red, generation: .first, cost: 8, qty: 3, capacity: 3, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Heavy I", livery: .yellow, generation: .first, cost: 12, qty: 2, capacity: 2, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Special I", livery: .blue, generation: .first, cost: 16, qty: 1, capacity: 1, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "General II", livery: .green, generation: .second, cost: 20, qty: 4, capacity: 4, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Fast Freight II", livery: .red, generation: .second, cost: 24, qty: 3, capacity: 3, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Heavy II", livery: .yellow, generation: .second, cost: 28, qty: 2, capacity: 3, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "General III", livery: .green, generation: .third, cost: 32, qty: 4, capacity: 4, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Special II", livery: .blue, generation: .second, cost: 36, qty: 2, capacity: 2, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Fast Freight III", livery: .red, generation: .third, cost: 40, qty: 3, capacity: 4, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "General IV", livery: .green, generation: .fourth, cost: 44, qty: 4, capacity: 5, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Heavy III", livery: .yellow, generation: .third, cost: 48, qty: 3, capacity: 3, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "Fast Freight IV", livery: .red, generation: .fourth, cost: 52, qty: 4, capacity: 4, rust: nil, orders: nil, sales: nil),
            Locomotive.init(id: UUID(), name: "General V", livery: .green, generation: .fifth, cost: 56, qty: 4, capacity: 5, rust: nil, orders: nil, sales: nil),
        ]
        return locos
    }
}


