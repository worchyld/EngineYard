//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

typealias Locomotive = Deck

protocol DeckDelegate {
    var name : String { get  }
    var color : EngineColor { get }
    var generation : Generation { get }

    var cost : Int { get }
    var productionCost : Int { get }
    var income : Int { get }

    var capacity : Int { get } // maximum dice capacity
}

enum DeckStatus : Int {
    case locked = 0
    case unlocked
}

class Deck : NSObject, DeckDelegate {

    // Each deck has a series of cards
    public private (set) var cards : [Card] = [Card]()

    public private (set) var name: String = ""
    public private (set) var cost: Int = 0
    public private (set) var productionCost: Int = 0
    public private (set) var income: Int = 0
    public private (set) var generation: Generation = .first
    public private (set) var color: EngineColor = .green
    public private (set) var capacity: Int = 0
    public private (set) var numberOfChildren: Int = 0

    public private (set) var status: DeckStatus = .locked

    // Deck.init(name: "Green.1", cost: 4, generation: .first, color: .green, capacity: 3, numberOfChildren: 4)
    init(name: String, cost: Int, generation: Generation, color: EngineColor, capacity: Int, numberOfChildren: Int) {
        assert(cost % 4 == 0, "Cost must be a modulus of 4")
        assert(capacity > 0, "Capacity must be > 0")
        assert(numberOfChildren > 0, "Number of Children must be > 0")

        super.init()

        self.name = name
        self.generation = generation
        self.color = color
        self.cost = cost
        self.productionCost = Int( cost / 2 )
        self.income = Int( self.productionCost / 2 )

        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        // Functional code to map the cards to children
        self.cards += (1...numberOfChildren).map{ _ in Card.init(parent: self) }
    }
}
