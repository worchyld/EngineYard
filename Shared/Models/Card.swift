//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum CardError : Error, Equatable {
    case cannotSelectCardFromSameParent
    case parentIsObsolete
    case cardDoesNotExist
    case cardAlreadyHasOwner
    case cardHasNoParent
    case alreadyHaveCardFromThisDeck
    case cannotFind(card: Card)
    case handIsEmpty
    case handHasNoOwner
    case couldNotHandleCard(card: Card)
}

class Card {
    public private (set) weak var parent: Deck?
    public private (set) weak var owner: Player?
    private let uid: UUID = UUID()
    public private (set) var units: Int = 0
    private var spentUnits: Int = 0

    init(parent: Deck) {
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

    func add(units: Int) {
        self.units += units
    }

    func spend(units: Int) {
        guard (canSpend(units: units)) else {
            return
        }
        self.spentUnits += units
        self.units -= units
    }

    func reset() {
        self.units += spentUnits
        self.spentUnits = 0
    }

    private func canSpend(units: Int) -> Bool {
        return true
    }
}


extension Card {
    public static func find(card: Card, in cards:[Card]) -> Card? {
        guard let card = (cards.filter({
            return $0 == card
        }).first) else {
            return nil
        }
        return card
    }

    public static func findIndexOf(card: Card, in cards:[Card]) -> Int? {
        guard (cards.count > 0) else {
            return nil
        }

        guard let index = (cards.firstIndex { (c: Card) -> Bool in
            return (c == card)
        }) else {
            return nil
        }

        return index
    }
}
