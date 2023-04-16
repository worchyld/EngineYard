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
    var existingOrders: [Int]
    var customerPool: [Int]
    var initialOrder: Int?
    var rust: Rust
    
    init(id: UUID = UUID(), name: String, generation: Generation, colour: EngineColor, cost: Int, trainPool: Int, maxDice: Int) {
        self.id = id
        self.name = name
        self.generation = generation
        self.colour = colour
        self.cost = cost
        self.trainPool = trainPool
        self.maxDice = maxDice
        self.existingOrders = [Int]()
        self.customerPool = [Int]()
        self.initialOrder = nil
        self.rust = .notBuilt
    }
}
