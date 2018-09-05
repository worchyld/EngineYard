//
//  Tableau.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

typealias Tableau = Hand

enum HandError: Error, Equatable {
    case handAlreadyHasCard
    case cannotFindCard
    case handIsEmpty
    case noOwnership
    case noParent
}

extension HandError {
    static func == (lhs: HandError, rhs: HandError) -> Bool {
        switch (lhs, rhs) {
        case (.handAlreadyHasCard, .handAlreadyHasCard):
            return true
        case (.cannotFindCard, .cannotFindCard):
            return true
        case (.handIsEmpty, .handIsEmpty):
            return true
        case (.noOwnership, .noOwnership):
            return true
        case (.noParent, .noParent):
            return true
        default:
            return false
        }
    }
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
        return ("Hand owner: \(ownership.name) - # Cards: \(self.cards.count)")
    }
}

extension Hand {
    func add(_ card: Card) throws {
        try checkCardHasParent(card: card)
        try checkOccurance(card)

        do {
            try willAdd(card: card)
        } catch let error {
            throw error
        }
    }

    func remove(_ card: Card) throws {
        try canRemove(card)
        //didRemove(card: Card)
    }

    private func willAdd(card: Card) throws {
        let cardOwner = try checkHandHasOwner()

        card.setOwner(owner: cardOwner)
        notifyObservers(card: card)
        self.cards.append(card)
    }

    private func didRemove(card: Card) {
        print ("REMOVE CARD CODE GOES HERE")
    }
}


extension Hand {

    private func canRemove(_ card: Card) throws {
        try checkCardHasParent(card: card)
        let _ = try checkHandHasOwner()
        try checkHandIsNotEmpty()
        if let result = try find(card) {
            print ("result: \(result)")
        }
    }

    private func checkHandHasOwner() throws -> Player {
        guard let owner = self.owner else {
            throw HandError.noOwnership
        }
        return owner
    }

    private func checkCardHasParent(card: Card) throws {
        guard card.parent != nil else {
            throw HandError.noParent
        }
    }

    private func checkHandIsNotEmpty() throws {
        guard self.cards.count > 0 else {
            throw HandError.handIsEmpty
        }
    }

    private func checkOccurance(_ card: Card) throws {
        let results = self.cards.filter{$0.parent == card.parent}.count
        guard results == 0 else {            
            throw HandError.handAlreadyHasCard
        }
    }

    private func find(_ card:Card) throws -> (Int, Card)? {
        guard let needle = (self.cards.enumerated().filter {
            (offset, element) -> Bool
            in
            return (index, element).1.parent == card.parent
            }).first
        else {
                return nil
        }
        return needle
    }


//     When a player adds a valid card to their hand;
//     it should automatically give it 1 production unit

    /*
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
 */
}


// MARK: Observers
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

