//
//  Tableau.swift
//  EngineYard
//
//  Created by Amarjit on 26/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// A player's hand / tableau of cards
class Tableau : CustomStringConvertible
{
    public private(set) weak var owner: Player?
    public private(set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
    }
}

extension Tableau {
    var description: String {
        return ("Tableau: \(self.cards.count)")
    }
}

extension Tableau {
    func contains(deck: Deck) -> Bool {
        // does my tableau already contain the train
        let filter1 = self.cards.contains(where: {
            return ($0.parent == deck)
        })
        if (filter1 == true) {
            return true
        }
        else {
            // is there any nil owner spaces available
            let results = deck.cards.filter({ (card) -> Bool in
                return (card.owner == nil)
            })
            return (results.count == 0)
        }
    }
}

extension Tableau {
    func add(card: Card) {
        guard let owner = self.owner else {
            assertionFailure("Tableau is unassigned")
            return
        }
        guard let _ = self.canAdd(card: card) else {
            return
        }
        self.willAdd(card: card, owner: owner)
    }

    private func willAdd(card:Card, owner: Player) {
        card.setOwner(as: owner)
        self.cards.append(card)
        // #TODO - Set production
    }

    internal func canAdd(card:Card) -> Bool? {
        // #TODO - Validation
        return false
    }
}
