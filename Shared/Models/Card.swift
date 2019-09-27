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
    public private(set) weak var owner: Player?
    private let uid: UUID = UUID()

    init(parent: Deck?) {
        self.parent = parent
    }
}

extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.uid == rhs.uid)
    }
}

extension Card {
    func setOwner(as player:Player) {
        guard canSetOwner(as: player) else {
            return
        }
        self.owner = player
    }

    private func canSetOwner(as player: Player) -> Bool {
        if let _ = self.owner {
            return false
        }
        return true
    }
}


