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


final class Deck : NSObject, DeckDelegate {
    public fileprivate (set) var subscribers: [GameBoardDelegate] = []

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
    public private (set) var rustedState: RustedState = .normal

    var active: Bool {
        return ((self.orderBook.existingOrderValues.count > 0) || (self.orderBook.completedOrderValues.count > 0))
    }

    // OrderBook
    lazy var orderBook: OrderBook = OrderBook(parent: self)
    var existingOrders : [Int] {
        return orderBook.existingOrderValues
    }
    var completedOrders : [Int] {
        return orderBook.completedOrderValues
    }
    var currentNumberOfDice: Int {
        return (self.existingOrders.count + self.completedOrders.count)
    }

    // Ownership
    var owners: [Player]? {
        return self.cards
            .lazy
            .flatMap { card in card.owner.map{ (card: card, owner: $0) } }
            //.sorted { $0.owner.turnOrder < $1.owner.turnOrder }
            .map { $0.owner }
    }

    // [- Init -]
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

    deinit {
        self.removeSubscribers()
    }
}

extension Deck {
    override var description: String {
        return "\(self.name), cards: \(cards.count), existingOrders: \(self.orderBook.existingOrderValues), completedOrders: \(self.orderBook.completedOrderValues)"
    }

    public static func ==(lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.name == rhs.name)
    }
}

extension Deck {

    /*
    func didUnlock() {
        self.orderBook.add(.existingOrder)
    }*/

    public static func didUnlock(deck: Deck) {
        deck.orderBook.add(.existingOrder)
    }

    public static func giveCardsFrom(deck:Deck, to players:[Player]) {
        for player in players {
            guard let card: Card = deck.cards.filter({ (c: Card) -> Bool in
                return (c.owner == nil)
            }).first else {
                assertionFailure("No card found in deck")
                return
            }
            card.production.setup()
            let _ = player.hand.add(card: card)
        }
    }
}

// MARK: - Subscription methods
extension Deck {
    func addSubscriber(_ subscriber: GameBoardDelegate) {
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
