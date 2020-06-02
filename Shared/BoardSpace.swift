//
//  BoardSpace.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum CardState: Int, CaseIterable {
   case unavailable, existing, old, obsolete
}

// Each board space holds a collection of cards
struct BoardSpace: Identifiable {
    let id: Int
    let color: Family.Color
    let generation: Family.Generation
    var deck: [Card] = [Card]()
    var dice: [Int] = [Int]()
    let cost: Int
    let orderCapacity: Int // Capacity of dice array

    init(id: Int = 0, cost: Int, color: Family.Color, generation: Family.Generation, orderCapacity: Int) {
        self.id = id
        self.cost = cost
        self.color = color
        self.generation = generation
        self.orderCapacity = orderCapacity
    }
}

extension BoardSpace : CustomDebugStringConvertible {
    var debugDescription: String {
        return ("id: \(id), color: \(color), \(generation) capacity: \(orderCapacity), # cards:\(deck.count)")
    }
}
