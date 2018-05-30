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

final class Hand : CustomStringConvertible {
    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
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

    func add(card: Card) -> Bool {
        guard let handOwnership = self.owner else {
            assertionFailure("Hand ownership is nil")
            return false
        }

        if let _ = find(card: card) {
            return false
        }

        card.setOwner(owner: handOwnership)

        self.cards.append(card)

        return true
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


