//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 16/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Card : CustomStringConvertible, Equatable
{
    private let uuid: String = UUID().uuidString
    public fileprivate(set) weak var parent : Deck?
    public fileprivate(set) weak var owner : Player?

    init(parent: Deck) {
        self.parent = parent
    }

}

extension Card {
    var description: String {
        guard let hasParent = self.parent else {
            return "No parent"
        }
        return hasParent.name
    }
}

extension Card {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}

extension Card {
    func setOwner(as player:Player) {
        self.owner = player
    }

    func isOwned(by player: Player?) -> Bool {
        return self.owner === player
    }
}
