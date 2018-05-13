//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Card : NSObject  {
    private let uuid: String = UUID().uuidString
    public fileprivate(set) weak var parent : Deck?
    public private (set) var production: Production = Production()

    init(parent: Deck) {
        super.init()

        self.parent = parent
    }
}

extension Card {
    override var description: String {
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
