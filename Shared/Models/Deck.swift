//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 16/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol DeckProtocol
{
    var name : String { get  }
    var color : EngineColor { get }
    var generation : Generation { get }

    var cost : Int { get }
    var productionCost : Int { get }
    var income : Int { get }

    var capacity : Int { get } // capacity for orders/customer base
    var numberOfChildren : Int { get }

    // Obsolescence
    var rusted : RustedState { get set }
    var owners : Int { get }
}

final class Deck : CustomStringConvertible, Equatable, DeckProtocol
{
    public fileprivate (set) var subscribers: [GameBoardProtocol] = []

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
    public internal (set) var rusted: RustedState = .normal
    public private (set) var owners: Int = 0

    var active: Bool {
        return ((self.existingOrderValues.count > 0) || (self.completedOrderValues.count > 0))
    }

    lazy var orderBook: OrderBook = OrderBook(parent: self) // existingOrders & completedOrders

    // Deck.init(name: "Green.1", cost: 4, generation: .first, color: .green, capacity: 3, numberOfChildren: 4)
    init(name: String, cost: Int, generation: Generation, color: EngineColor, capacity: Int, numberOfChildren: Int) {
        assert(cost % 4 == 0, "Cost must be a modulus of 4")
        assert(capacity > 0, "Capacity must be > 0")
        assert(numberOfChildren > 0, "Number of Children must be > 0")

        self.name = name
        self.generation = generation
        self.color = color
        self.cost = cost
        self.productionCost = Int( cost / 2 )
        self.income = Int( self.productionCost / 2 )

        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        // functional code to map the cards to children
        self.cards += (1...numberOfChildren).map{ _ in Card.init(parent: self) }
    }
}

extension Deck {
    var description: String {
        let returnString = "Deck: \(self.name), cards: #\(self.cards.count), gen: \(self.generation), color: \(self.color), cost: $\(self.cost), production: $\(self.productionCost), income: $\(self.income), active: \(self.active), rusted: \(self.rusted)"

        return returnString
    }
}

extension Deck {
    public static func ==(lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.name == rhs.name)
    }
}

// Obsolescence basic state changing methods
extension Deck {
    private func setRusted(as state:RustedState) {
        self.rusted = state
    }

    func markAsOld() {
        self.setRusted(as: .old)
    }

    func markAsObsolete() {
        self.setRusted(as: .obsolete)
    }
}

// Unlocking methods
extension Deck {

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

    internal func unlock() {
        self.orderBook.add(.existingOrder)
    }

}

// Subscription methods (uses subscription pattern)
extension Deck {
    func addSubscriber(_ subscriber: GameBoardProtocol) {
        self.subscribers.append(subscriber)
    }

    func notifySubscribers() {
        let _ = self.subscribers.map({
            $0.unlockNextDeck(self)
        })
    }

    func removeSubscribers() {
        self.subscribers.removeAll()
    }
}

