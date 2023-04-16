//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

class Locomotive : Identifiable {
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
    var maxDice: Int
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
            return ((self.existingOrders.count + self.customerBase.count) >= self.maxDice)
        }
    }
    var hasDice: Bool {
        get {
            return (self.existingOrders.count > 0 || self.customerBase.count > 0)
        }
    }
    
    
    init(id: UUID = UUID(), name: String, generation: Generation, colour: EngineColor, cost: Int, trainPool: Int, maxDice: Int) {
        self.id = id
        self.name = name
        self.generation = generation
        self.colour = colour
        self.cost = cost
        self.trainPool = trainPool
        self.maxDice = maxDice
        self.rust = .notBuilt
        self.existingOrders = [Int]()
        self.customerBase = [Int]()
        self.initialOrder = nil
    }
}

extension Locomotive {
    func rustify() {
        self.rust.rustify()
    }
}
