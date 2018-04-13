//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Card : CustomStringConvertible, Equatable
{
    private let uuid: String = UUID().uuidString
    public fileprivate(set) weak var parent : Deck?

    init(parent: Deck) {
        self.parent = parent
    }

}

extension Card {

    var description: String {
        guard let hasParent = self.parent else {
            return "No parent found"
        }
        return hasParent.name
    }

}

extension Card {
    // Equality check
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}

