//
//  Tableau.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

typealias Tableau = Hand

enum HandError: Error {
    case alreadyOwnThisTypeOfCard
    case cannotFindCard
}

protocol HandObserver : class {
    func didAdd(card: Card)
}

extension HandObserver {
    func didAdd(card: Card) {
        card.production.add(1)
    }
}

final class Hand : CustomStringConvertible, HandObserver {
    private var observerArray = [HandObserver]()

    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
        self.attachObserver(observer: self as HandObserver)
    }

    deinit {
        self.removeSubscribers()
    }
}

extension Hand {
    var description: String {
        guard let ownership = self.owner else {
            return "No owner"
        }
        return ("Hand owner: \(ownership) - Cards: \(self.cards.count)")
    }
}

extension Hand {

    /*
     When a player adds a valid card to their hand;
     it should automatically give it 1 production unit

     ie.
     After a player has developed a locomotive, he takes
     the corresponding locomotive card, then
     takes one Production Unit counter and places
     it on the locomotive card, with side “1” face up.
     */
    func add(_ card: Card) {
        guard let handOwnership = self.owner else {
            assertionFailure("Hand ownership is nil")
            return
        }

        if let _ = find(card: card) {
            return
        }

        card.setOwner(owner: handOwnership)
        notifyObservers(card: card)

        self.cards.append(card)
    }

    // #TODO - Remove card
    func remove(card: Card) -> Bool {
        if let _ = find(card: card) {
            // remove card
            return true
        }
        return false
    }

    // A player cannot own a card from the same parent
    func find(card: Card) -> Card? {
        guard let needle : Card = self.cards.filter({ (c: Card) -> Bool in
            return c.parent == card.parent
        }).first else {
            return nil
        }
        return needle
    }
}

extension Hand {
    func attachObserver(observer: HandObserver) {
        observerArray.append(observer)
    }
    fileprivate func notifyObservers(card: Card) {
        for observer in observerArray {
            observer.didAdd(card: card)
        }
    }

    fileprivate func removeSubscribers() {
        self.observerArray.removeAll()
    }

}

