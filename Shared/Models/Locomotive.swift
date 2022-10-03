//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 24/09/2022.
//

import Foundation

final class Locomotive {
    private let uuid: UUID = UUID()
    var name: String {
        return livery.description.lowercased() + "." + generation.description.lowercased()
    }
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
    
    private var _rust: Rust = .notBuilt
    private var _available: Bool = false
    
    public var rust: Rust {
        return _rust
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
    
    public func age() {
        self._rust.age()
    }
    
    public func toggleAvailability() {
        self._available = !self._available
    }
}

extension Locomotive : CustomStringConvertible {
    var description: String {
        return (self.name)
    }
}

extension Locomotive : Equatable {
    static func == (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
    static func > (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue > rhs.generation.rawValue)
    }
    static func < (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue < rhs.generation.rawValue)
    }
}
