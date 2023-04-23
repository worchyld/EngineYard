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
    var existingOrders: [Int]
    var customerBase: [Int]
    var rust: Rust
    
    var isDicePoolEmpty: Bool {
        get {
            return ((self.existingOrders.isEmpty) && (self.customerBase.isEmpty))
        }
    }
    var isDicePoolFull: Bool {
        get {
            return ((self.existingOrders.count + self.customerBase.count) >= self.dicePoolCapacity)
        }
    }
    var hasDice: Bool {
        get {
            return (self.existingOrders.count > 0 || self.customerBase.count > 0)
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
        self.existingOrders = orders
        self.customerBase = sales
        self.initialOrder = initialOrder
    }
}

extension Locomotive {
    func rustify() {
        self.rust.rustify()
    }
}

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
            
            /*
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
             */
        ]
        return locos
    }
    
    
}
