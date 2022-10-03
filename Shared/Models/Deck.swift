//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

class Deck {
    private let uuid: UUID = UUID()
    public let loco: Locomotive
    public var cards: [Card] = [Card]()

    // Lookup vars
    var cost: Int {
        return loco.cost
    }
    var productionCost: Int {
        return loco.productionCost
    }
    var income: Int {
        return loco.income
    }
    var livery: Livery {
        return loco.livery
    }
    var generation: Generation {
        return loco.generation
    }
    var rust: Rust {
        return loco.rust
    }
    
    init(locomotive: Locomotive, cards: [Card]) {
        self.loco = locomotive
        self.cards = cards
    }
    
    public var isEmpty : Bool {
        return (self.cards.count == 0)
    }
}

extension Deck : Equatable {
    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}

extension Deck : CustomStringConvertible {
    var description: String {
        return ("Deck: { \(self.loco.livery) \(self.loco.generation) }")
    }
}
