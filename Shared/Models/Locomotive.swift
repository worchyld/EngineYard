//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

class Locomotive {
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    let trainPool: Int
    let maxDice: Int
    var rust: Rust
    var orders: [Int] = [Int]()
    var sales: [Int] = [Int]()
    var available: Bool
    
    init(name: String, image: String, cost: Int, livery: Livery, generation: Generation, trainPool: Int, maxDice: Int) {
        self.name = name
        self.image = image
        self.cost = cost
        self.livery = livery
        self.generation = generation
        self.trainPool = trainPool
        self.maxDice = maxDice
        self.rust = .notbuilt
        self.available = false
    }
}
