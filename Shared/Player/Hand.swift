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
    case alreadyHaveThisCard
    case sameCardFromThisDeck
    case cannotFindCard
    case handIsEmpty
    case noOwnership
    case noParent
    case cannotSelectSameCard
    case cannotSelectCardFromSameParent
    case cannotSelectDownstream
}

extension HandError {
    static func == (lhs: HandError, rhs: HandError) -> Bool {
        switch (lhs, rhs) {
        case (.alreadyHaveThisCard, .alreadyHaveThisCard):
            return true
        case (.sameCardFromThisDeck, .sameCardFromThisDeck):
            return true
        case (.cannotFindCard, .cannotFindCard):
            return true
        case (.handIsEmpty, .handIsEmpty):
            return true
        case (.noOwnership, .noOwnership):
            return true
        case (.noParent, .noParent):
            return true
        case (cannotSelectSameCard, cannotSelectSameCard):
            return true
        case (cannotSelectCardFromSameParent, cannotSelectCardFromSameParent):
            return true
        case (cannotSelectDownstream, cannotSelectDownstream):
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

final class Hand : NSObject, NSCopying, HandObserver {
    private var observerArray = [HandObserver]()

    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

    init(owner: Player) {
        super.init()
        self.owner = owner
        self.attachObserver(observer: self as HandObserver)
    }

    deinit {
        self.removeSubscribers()
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Hand(owner: self.owner!)
        let duplicateHand = self.cards.map { (c: Card) -> Card in
            return (c.copy(with: zone)) as! Card
        }
        copy.cards = duplicateHand
        return copy
    }
}

extension Hand {
    override var description: String {
        guard let ownership = self.owner else {
            return "No owner"
        }
        return ("Hand owner: \(String(describing: ownership.name)) - # Cards: \(self.cards.count)")
    }
}

extension Hand {
    func add(_ card: Card) throws {
        try checkCardHasParent(card)
        try checkParentOccurance(card)
        try checkCardOccurance(card)

        do {
            try willAdd(card: card)
        } catch let error {
            throw error
        }
    }

    func remove(_ card: Card) throws {
        guard let result = try canRemove(card) else {
            throw HandError.cannotFindCard
        }
        guard let _ = self.cards.first(where: { (c: Card) -> Bool in
            return (c == result.1)
        }) else {
            throw HandError.cannotFindCard
        }
        willRemove(card: result.1, atIndex: result.0)
    }

    func empty() {
        self.cards.removeAll()
    }
}


extension Hand {
    private func willAdd(card: Card) throws {
        let cardOwner = try checkHandHasOwner()
        card.setOwner(owner: cardOwner)
        notifyObservers(card: card)
        self.cards.append(card)
    }

    private func willRemove(card: Card, atIndex: Int) {
        print ("Will remove card: \(card.description) at index: \(atIndex)")
        card.removeOwner()
        self.cards.remove(at: atIndex)
    }


    private func canRemove(_ card: Card) throws -> (Int, Card)? {
        try checkCardHasParent(card)
        let _ = try checkHandHasOwner()
        try checkHandIsNotEmpty()

        // Find card in hand
        if let result = try find(card) {
            return result
        }
        return nil
    }

    private func checkHandHasOwner() throws -> Player {
        guard let owner = self.owner else {
            throw HandError.noOwnership
        }
        return owner
    }

    private func checkCardHasParent(_ card: Card) throws {
        guard card.parent != nil else {
            throw HandError.noParent
        }
    }

    private func checkHandIsNotEmpty() throws {
        guard self.cards.count > 0 else {
            throw HandError.handIsEmpty
        }
    }

    private func checkParentOccurance(_ card: Card) throws {
        let results = self.cards.filter{$0.parent == card.parent}.count
        if (results > 0) {
            throw HandError.sameCardFromThisDeck
        }
    }

    private func checkCardOccurance(_ card: Card) throws {
        let results = self.cards.filter{$0.name == card.name}.count
        if (results > 0) {
            throw HandError.alreadyHaveThisCard
        }
    }

    private func find(_ card:Card) throws -> (Int, Card)? {
        guard let needle = (self.cards.enumerated().filter {
            (offset, element) -> Bool
            in
            return (index, element).1 == card
            }).first
        else {
            return nil
        }
        return needle
    }
}

// MARK: Production shift functions
extension Hand {
    public static func costToShift(amount: Int, from: Card, to: Card) throws -> Int {
        do {
            try canShift(amount: amount, from: from, to: to)
        } catch let error as ProductionError {
            throw error
        }

        return ((to.production.cost - from.production.cost) * amount)
    }


    private static func canShift(amount: Int, from: Card, to: Card) throws {
        guard amount > 0 else {
            throw NumberError.mustBePositive
        }
        guard from != to else {
            throw HandError.cannotSelectSameCard
        }
        guard from.parent != to.parent else {
            throw HandError.cannotSelectCardFromSameParent
        }
        // Shifting production can only go upstream
        guard ((from.parent?.cost)! < (to.parent?.cost)!) else {
            throw HandError.cannotSelectDownstream
        }
    }
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

