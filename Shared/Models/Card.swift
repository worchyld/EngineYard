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
    private weak var parent: Deck?
    private weak var owner: Player?
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


