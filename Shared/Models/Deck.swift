//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

protocol DeckProtocol {
    var name : String { get  }
    var type : DeckType { get }
    var generation : Generation { get }

    var cost : Int { get }
    var productionCost : Int { get }
    var income : Int { get }

    var capacity : Int { get } // capacity for orders/customer base
    var numberOfChildren : Int { get }

    // Obsolescence
    var state : CardState { get set }
    var owners : Int { get }
}

final class Deck : DeckProtocol {
    public private (set) var cards: [Card] = [Card]()

    public private (set) var name: String
    public private (set) var type: DeckType
    public private (set) var generation: Generation
    public private (set) var cost: Int
    public private (set) var productionCost: Int
    public private (set) var income: Int
    public private (set) var capacity: Int
    public private (set) var numberOfChildren: Int
    public internal (set) var state: CardState
    public private (set) var owners: Int

    init(name: String, type: DeckType, generation: Generation, cost: Int, capacity: Int, numberOfChildren: Int) {
        assert(cost % 4 == 0, "Cost must be a multiple of 4")
        self.name = name
        self.type = type
        self.generation = generation
        self.cost = cost
        self.productionCost = (cost / 2)
        self.income = (productionCost / 2)
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren
        self.state = .inactive
        self.owners = 0
    }
}

extension Deck : CustomStringConvertible {
    var description: String {
        return (self.name)
    }
}
