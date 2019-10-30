//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

final class Deck {
    enum State: Int {
        case inactive = 0
        case active
        case rusting
        case rusted = -1 // Obsolete
    }
    enum Color: Int, CaseIterable {
        case green = 1  // Passenger
        case red    // Fast
        case yellow // Freight
        case blue   // Special
    }
    enum Generation: Int, CaseIterable  {
        case first = 1
        case second
        case third
        case fourth
        case fifth
    }

    private let uid: UUID = UUID()
    let name: String
    let color: Deck.Color
    let generation: Deck.Generation
    let cost: Int
    var productionCost: Int {
        return Int(cost / 2)
    }
    var income: Int {
        return Int(productionCost / 2) 
    }
    let capacity: Int
    let numberOfChildren: Int
    public private (set) var state: Deck.State = .inactive

    //: Orders
    lazy var orderBook: OrderBook = OrderBook(deck: self) // order book & completedOrders book
    public var orders: [Order] {
        return self.orderBook.orders
    }

    //: Cards
    private var _cards: [Card] = [Card]()
    public var cards: [Card] {
        return self._cards
    }

    //: Ownership
    var owners: [Player]? {
        return self.cards
            .lazy
            .compactMap { card in card.owner.map{ (card: card, owner: $0) } }
            //.sorted { $0.owner.turnOrder < $1.owner.turnOrder }
            .map { $0.owner }
    }


    init(name: String, cost: Int, generation: Deck.Generation, color: Deck.Color, capacity: Int, numberOfChildren: Int) {
        assert(cost % 4 == 0, "Cost must be a multiple of 4")
        self.name = name
        self.color = color
        self.generation = generation
        self.cost = cost
        self.numberOfChildren = numberOfChildren
        self.capacity = capacity
        self.state = .inactive

        // Functional code to map cards
        self._cards += (1...numberOfChildren).map{ _ in Card(parent: self) }
    }
}

extension Deck: Equatable {
    public static func ==(lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.uid == rhs.uid)
    }
}

extension Deck: CustomStringConvertible {
    public var description: String {
        return "\(self.name)"
    }
}

extension Deck {
    public static func findFirstUnownedCard(in deck: Deck) -> Card? {
        guard let card = (deck.cards.filter({ (card) -> Bool in
            return (card.owner == nil)
        }).first) else {
            return nil
        }

        return card
    }

    var existingOrderValues: [Int] {
        return orderBook.existingOrders.compactMap({ (o:Order) -> Int in
            return o.value
        })

    }

    var completedOrderValues: [Int] {
        return orderBook.completedOrders.compactMap({ (o:Order) -> Int in
            return o.value
        })
    }

    func activate() {
        self.state = .active
    }
}
