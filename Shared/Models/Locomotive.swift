//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

final class Locomotive : Identifiable {
    let id: UUID
    let name : String
    let generation : Generation
    let colour : EngineColor
    var icon: String {
        get {
            return self.colour.icon
        }
    }
    let cost : Int
    var productionCost: Int {
        get {
            return Int(round(Double(self.cost) / 2))
        }
    }
    var income: Int {
        get {
            return Int(round(Double(self.productionCost) / 2))
        }
    }
    var trainPool: Int
    var dicePoolCapacity: Int
    var initialOrder: Int?
    var orders: [Int] // existingOrders
    var sales: [Int] //customerBase
    var rust: Rust
    
    var isDicePoolEmpty: Bool {
        get {
            return ((self.orders.isEmpty) && (self.sales.isEmpty))
        }
    }
    var isDicePoolFull: Bool {
        get {
            return ((self.orders.count + self.sales.count) >= self.dicePoolCapacity)
        }
    }
    var hasDice: Bool {
        get {
            return (self.orders.count > 0 || self.sales.count > 0)
        }
    }
    var isActive: Bool {
        get {
            return (self.rust.isActive && self.hasDice)
        }
    }
    
    
    init(id: UUID, name: String, colour: EngineColor, generation: Generation, cost: Int, trainPool: Int, capacity: Int, rust: Rust, orders: [Int], sales: [Int], initialOrder: Int?) {
        self.id = id
        self.name = name
        self.generation = generation
        self.colour = colour
        self.cost = cost
        self.trainPool = trainPool
        self.dicePoolCapacity = capacity
        self.rust = rust
        self.orders = orders
        self.sales = sales
        self.initialOrder = initialOrder
    }
}

extension Locomotive {
    func rustify() {
        self.rust.rustify()
    }
}

extension Locomotive: CustomDebugStringConvertible {
    var debugDescription: String {
        let initialOrderString = String(describing: self.initialOrder)
        
        return ("\nID: \(id), initialOrder: \(initialOrderString), orders: \(self.orders), sales: \(self.sales), state: \(self.rust)")
    }
}

// MARK: Locomotive Data 

extension Locomotive {
    
    internal static func allLocos() -> [Locomotive] {
        let locos: [Locomotive] = [
            Locomotive.init(id: UUID(), name: "", colour: .green, generation: .first, cost: 4, trainPool: 4, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .red, generation: .first, cost: 8, trainPool: 3, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .yellow, generation: .first, cost: 12, trainPool: 2, capacity: 2, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .blue, generation: .first, cost: 16, trainPool: 1, capacity: 1, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .green, generation: .second, cost: 20, trainPool: 4, capacity: 4, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .red, generation: .second, cost: 24, trainPool: 3, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .yellow, generation: .second, cost: 28, trainPool: 2, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .green, generation: .third, cost: 32, trainPool: 4, capacity: 4, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .blue, generation: .second, cost: 36, trainPool: 2, capacity: 2, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .red, generation: .third, cost: 40, trainPool: 3, capacity: 4, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .green, generation: .fourth, cost: 44, trainPool: 4, capacity: 5, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .yellow, generation: .third, cost: 48, trainPool: 3, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .red, generation: .fourth, cost: 52, trainPool: 4, capacity: 4, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil),
            Locomotive.init(id: UUID(), name: "", colour: .green, generation: .fifth, cost: 56, trainPool: 4, capacity: 5, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil)
        ]
        return locos
    }
}
