//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum DeckState: Int, CaseIterable {
   case unavailable, existing, old, obsolete
}

// The board is a collection of `decks`, each holding a collection of `cards`
class Deck: Identifiable, FamilyDelegate {
    let id: UUID = UUID()
    let color: Family.Color
    let generation: Family.Generation
    let cost: Int
    let orderCapacity: Int // Capacity of dice array
    var cards: [Card] = [Card]()
    var dice: [Int] = [Int]()
    var state: DeckState = DeckState.unavailable

    init(_ cost: Int, _ color: Family.Color, _ generation: Family.Generation, _ orderCapacity: Int) {
        self.cost = cost
        self.color = color
        self.generation = generation
        self.orderCapacity = orderCapacity
    }
}

extension Deck : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("id: \(id), color: \(color), \(generation) capacity: \(orderCapacity), # cards:\(cards.count)")
    }
}
