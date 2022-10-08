//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 24/09/2022.
//

import Foundation

final class Locomotive : Hashable, Identifiable {
    internal let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id + self.generation.rawValue + self.livery.rawValue)
    }
    
    var name: String
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
    let qty: Int
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
    
    init(_ id: Int = 0, _ name: String, _ cost: Int, _ livery: Livery, _ generation: Generation, _ qty: Int, _ maxDice: Int) {
        self.id = id
        self.name = name
        self.cost = cost
        self.generation = generation
        self.livery = livery
        self.qty = qty
        self.maxDice = maxDice
    }
}

extension Locomotive : CustomStringConvertible {
    var description: String {
        return (livery.description.lowercased() + "." + generation.description.lowercased())
    }
}

extension Locomotive : Equatable {
    static func == (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.id == rhs.id)
    }
    static func > (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue > rhs.generation.rawValue)
    }
    static func >= (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue >= rhs.generation.rawValue)
    }
    static func < (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue < rhs.generation.rawValue)
    }
    static func <= (lhs: Locomotive, rhs: Locomotive) -> Bool {
        return (lhs.generation.rawValue <= rhs.generation.rawValue)
    }
}

extension Locomotive {
    public func age() {
        self._rust.age()
    }
    
    public func toggleAvailability() {
        self._available = !self._available
    }
}
