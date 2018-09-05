//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

final class Card : NSObject  {
    public let name: String = UUID().uuidString

    public private(set) weak var parent : Deck?
    public private(set) weak var owner : Player?
    public private (set) var production: Production = Production()

    init(parent: Deck) {
        super.init()
        self.parent = parent
    }

    deinit {
        self.owner = nil
        self.parent = nil
    }
}

extension Card {
    override var description: String {
        var parentName = "No parent"
        if let parentObj = self.parent {
            parentName = parentObj.name
        }
        var cardOwnerName = "No owner"
        if let cardObj = self.owner {
            cardOwnerName = cardObj.name
        }

        return ("Card: \(parentName), owner >> \(cardOwnerName), units: \(production.units)")
    }
}

extension Card {
    public static func ==(lhs: Card, rhs: Card) -> Bool {        
        return ((lhs.name == rhs.name) && (lhs.parent?.name == rhs.parent?.name))
    }

    func setOwner(owner: Player) {
        self.owner = owner
    }

    func removeOwner() {
        self.owner = nil
    }

    func isOwned(by player: Player?) -> Bool {
        return self.owner === player
    }
}


