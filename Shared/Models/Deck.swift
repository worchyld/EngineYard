//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Deck {
    enum State: Int {
        case inactive = 0
        case active
        case rusting
        case rusted = -1 // Obsolescent
    }
    enum Color: Int {
        case green = 1  // Passenger
        case red    // Fast
        case yellow // Freight
        case blue   // Special

        static let allRawValues = Color.green.rawValue...Color.blue.rawValue
        static let allValues = Array(allRawValues.map{ Color(rawValue: $0)! })
    }
    enum Generation: Int {
        case first = 1
        case second
        case third
        case fourth
        case fifth

        static let allRawValues = Generation.first.rawValue...Generation.fifth.rawValue
        static let allValues = Array(allRawValues.map{ Generation(rawValue: $0)! })
    }

    let color: Deck.Color
    let generation: Deck.Generation
    var name: String {
        return ("\(String(describing: self.color)) #\(String(describing: self.generation))")
    }
    let cost: Int
    var productionCost: Int? {
        guard (cost % 4 == 0) else {
            return nil
        }
        return Int(cost / 2)
    }
    var income: Int? {
        guard let productionCost = self.productionCost else {
            return nil
        }
        guard (productionCost % 4 == 0) else {
            return nil
        }
        return Int(productionCost / 2)
    }
    let cards: [Card]
    let orders: [Int]
    let sales: [Int]
    let capacity: Int
    let numberOfChildren: Int
    let state: Deck.State

    init(color: Deck.Color, generation: Deck.Generation, cost: Int, capacity: Int, numberOfChildren: Int) {
        assert(cost % 4 == 0, "Cost must be a multiple of 4")
        self.color = color
        self.generation = generation
        self.cost = cost
        self.numberOfChildren = numberOfChildren
        self.capacity = capacity
        self.state = .inactive
        self.cards = [Card]()
        self.orders = [Int]()
        self.sales = [Int]()
    }
}
