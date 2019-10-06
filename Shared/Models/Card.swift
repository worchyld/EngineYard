//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum CardError : Error {
    case cannotSelectCardFromSameParent
    case parentIsObsolete
    case cardDoesNotExist
    case cardAlreadyHasOwner
    case cardHasNoParent
}

class Card {
    public private (set) weak var parent: Deck?
    public private (set) weak var owner: Player?
    private let uid: UUID = UUID()
    let units: Int

    init(parent: Deck) {
        self.units = 0
        self.parent = parent
    }
}

extension Card : CustomStringConvertible {
    var description: String {
        guard let parent = self.parent else {
            return ("\(CardError.cardHasNoParent)")
        }
        return parent.name
    }
}

extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.uid == rhs.uid)
    }
}

extension Card {
    func setOwner(owner: Player) {
        self.owner = owner
    }
}

extension Card {
    public static func findFirstUnownedCard(in deck: Deck) -> Card? {
        guard let card = (deck.cards.filter({ (card) -> Bool in
            return (card.owner == nil)
        }).first) else {
            return nil
        }

        return card
    }
}

