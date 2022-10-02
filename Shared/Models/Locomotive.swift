//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 24/09/2022.
//

import Foundation

struct Locomotive {
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
    let rusted: Rust
    let available: Bool
    let trainPool: Int
    
    init(_ cost: Int, _ livery: Livery, _ generation: Generation, _ trainPool: Int,
         _ rust: Rust = .notBuilt , _ available: Bool = false) {
        self.cost = cost
        self.generation = generation
        self.livery = livery
        self.trainPool = trainPool
        self.available = available
        self.rusted = rust
    }
    
    enum Change {
        case obsolence(Rust)
        case availability(Bool)
    }
    
    func execute(_ change: Change) -> Self {
        switch change {
        case .obsolence( let r): return .init(cost, livery, generation, trainPool, r, available)
        case .availability( let a): return .init(cost, livery, generation, trainPool, rusted, a)
        }
    }
}
