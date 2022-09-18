//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

// Each train has these 3 common things
protocol TrainSpecificationDelegate {
    var cost: Int  { get }
    var livery: Livery  { get }
    var generation: Generation  { get }
}

class Deck : TrainSpecificationDelegate {
    private let uuid: UUID
    public var cards: [Card] = [Card]()
    let cost: Int    
    public var productionCost: Int {
        return cost / 2
    }
    public var income: Int {
        return self.productionCost / 2
    }
    
    let maxDice: Int
    let livery: Livery
    let generation: Generation
    var rust: Rust = .notBuilt
    var available: Bool = false
    var dicePool: [D6] = [D6]()
    
    init(_ cost: Int, _ livery: Livery, _ generation: Generation, _ maxDice: Int) {
        self.uuid = UUID()
        self.cost = cost
        self.maxDice = maxDice
        self.livery = livery
        self.generation = generation
        self.rust = .notBuilt
        self.available = false
    }
    
    public func addToDicePool(d6: D6) {
        self.dicePool.append(d6)
    }
    
    public func age() {
        self.rust.age()
    }
    
    public func toggleAvailability() {
        self.available = !self.available
    }
}

extension Deck : Equatable {
    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}
