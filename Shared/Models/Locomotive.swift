//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 24/09/2022.
//

import Foundation

final class Locomotive {
    private let uuid: UUID = UUID()
    var avatar: String {
        return self.livery.iconAsset
    }
    let cost: Int
    var productionCost: Int {
        return Int(self.cost / 2)
    }
    var income: Int {
        return Int(self.productionCost / 2)
    }
    let generation: Generation
    let livery: Livery
    let trainPool: Int
    let maxDice: Int
    
    private var _rusted: Rust = .notBuilt
    private var _available: Bool = false
    
    public var rusted: Rust {
        return _rusted
    }
    public var available: Bool {
        return _available
    }
        
    public private (set) var dicePool: [Int] = [Int]()
    
    init(_ cost: Int, _ livery: Livery, _ generation: Generation, _ trainPool: Int, _ maxDice: Int) {
        self.cost = cost
        self.generation = generation
        self.livery = livery
        self.trainPool = trainPool
        self.maxDice = maxDice
    }
}
