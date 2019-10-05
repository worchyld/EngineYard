//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum HandError: Error {
    case alreadyHave(card: Card)
    case cannotFind(card: Card)
    case handIsEmpty
    case handHasNoOwner
}

class Hand {
    public private(set) weak var owner: Player?
    private var _cards: [Card] = [Card]()
    public var cards: [Card] {
        return self._cards
    }

    init(owner: Player) {
        self.owner = owner
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}

extension Hand {
    // add card to a players hand
    func push(card: Card) {
        guard let owner = self.owner else {
            assertionFailure("No player owns this hand")
            return
        }
        card.setOwner(owner: owner)
        self._cards.append(card)
    }

    // pop a card from a players hand
    func pop(card: Card) {

    }
}
