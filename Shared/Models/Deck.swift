//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// In the game, decks are called Locomotives; but I find it
// easier to conceptualise them as decks - because each deck has
// a collection of cards within them

protocol DeckProtocol {
    var name: String { get }
    var cost: Int  { get }
    var generation: Int { get }
    var color: Int  { get }
    var orderCapacity: Int  { get }
    var numberOfChildren: Int  { get }
}

class Deck: Decodable, DeckProtocol, Identifiable {
    // : enums
    enum State: Int, CaseIterable {
        case inactive = 0
        case active
        case rusting
        case rusted = -1 // Obsolete

        static let allRawValues = Deck.State.inactive.rawValue...Deck.State.rusted.rawValue
    }
    enum Color: Int, CaseIterable {
        case green = 1  // Passenger
        case red    // Fast
        case yellow // Freight
        case blue   // Special

        static let allRawValues = Deck.Color.green.rawValue...Deck.Color.blue.rawValue
    }
    enum Generation: Int, CaseIterable  {
        case first = 1
        case second
        case third
        case fourth
        case fifth

        static let allRawValues = Deck.Generation.first.rawValue...Deck.Generation.fifth.rawValue
    }

    // : Structure 
    let id: UUID = UUID()
    let name: String
    let cost: Int
    let generation: Int
    let color: Int
    let orderCapacity: Int
    let numberOfChildren: Int
    let cards: [Card] = [Card]()
    var orders: [Order] = [Order]()

    private enum CodingKeys: String, CodingKey {
         case name, cost, generation, color, orderCapacity, numberOfChildren
    }
}

extension Deck : CustomStringConvertible {
    var description: String {
        return "name: \(name), cost:\(cost), generation: \(generation), color: \(color), capacity:\(orderCapacity), numberOfChildren: \(numberOfChildren)"
    }
}
