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


final class Deck : NSObject, NSCopying, DeckDelegate {
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
        return (
            (self.orderBook.existingOrderValues.count > 0) ||
            (self.orderBook.completedOrderValues.count > 0) ||
            (self.owners!.count > 0)
        )
    }

    // OrderBook
    lazy var orderBook: OrderBook = OrderBook(parent: self)

    // Ownership
    var owners: [Player]? {
        return self.cards
            .lazy
            .compactMap { card in card.owner.map{ (card: card, owner: $0) } }
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
    }

    func addChildCards() {
        guard self.cards.count == 0 else {
            return
        }
        // Functional code to add child cards
        self.cards += (1...numberOfChildren).map{ _ in Card.init(parent: self) }
    }

    deinit {
        self.removeSubscribers()
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Deck.init(name: self.name, cost: self.cost, generation: self.generation, color: self.color, capacity: self.capacity, numberOfChildren: self.numberOfChildren)
        copy.cards = self.cards
        copy.orderBook = self.orderBook.copy(with: zone) as! OrderBook

        return copy
    }
}

extension Deck {
    override var description: String {
        return "\(self.name), cards: \(cards.count), rusted: \(rustedState)\n\texistingOrders: \(self.orderBook.existingOrderValues),\n\t completedOrders: \(self.orderBook.completedOrderValues)\n\t #owners: \(String(describing: self.owners?.count))"
    }

    public static func ==(lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.name == rhs.name)
    }
}

extension Deck {
    
    public static func didUnlock(deck: Deck) {
        deck.orderBook.add(.existingOrder)
    }

    public static func giveCardsFrom(deck:Deck, to players:[Player]) {

        for player in players {
            guard let cardObj: Card = deck.cards.filter({ (c: Card) -> Bool in
                return (c.owner == nil)
            }).first else {
                assertionFailure("No card found in deck")
                return
            }
            do {
                try player.hand.add(cardObj)
            } catch let error {
                assertionFailure(error.localizedDescription as String)
            }
        }
    }
}

extension Deck {
    func findFirstUnownedCard() -> Card? {
        guard let card = (cards
            .filter({ (c: Card) -> Bool in
                return (c.owner == nil)
            }).first)
            else {
                return nil
        }
        return card
    }

    func markAsOld() {
        self.rustedState = .old
    }

    func markAsObsolete() {
        self.rustedState = .obsolete
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
