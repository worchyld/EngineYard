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
    private var _cards: [Card] = [Card]()
    public var cards: [Card] {
        return self._cards
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}

extension Hand {
    func push(card: Card) {

    }

    func pop(card: Card) {

    }
}
