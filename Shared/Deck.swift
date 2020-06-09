//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of `decks`, each holding a collection of `cards`
class Deck: Identifiable, FamilyDelegate {
    let id: UUID = UUID()
    let family: Family
    var color: Family.Color { return self.family.color }
    var generation: Family.Generation { return self.family.generation }
    let cost: Int
    let orderCapacity: Int // Capacity of dice array
    var cards: [Card] = [Card]()
    var dice: [Int] = [Int]()

    enum State: Int, CaseIterable {
       case unavailable, existing, old, obsolete
    }
    var state: Deck.State = Deck.State.unavailable

    init(_ cost: Int, _ color: Family.Color, _ generation: Family.Generation, _ orderCapacity: Int) {
        self.cost = cost
        //self.color = color
        //self.generation = generation
        self.family = Family(color: color, generation: generation)
        self.orderCapacity = orderCapacity
    }
}

extension Deck : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("id: \(id), color: \(color), \(generation) capacity: \(orderCapacity), # cards:\(cards.count)")
    }
}