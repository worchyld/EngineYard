//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

// Each player has their own hand of cards
class Hand {
    public private(set) weak var owner: Player?
    public private(set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
    }
}

extension Hand {
    // #TODO
    func add(card: Card) {

    }

    // #TODO
    func remove(card: Card) {

    }

    // #TODO
    private func canAdd(card: Card) -> Bool {
        return true
    }

    // #TODO
    private func canRemove(card: Card) -> Bool {
        return true
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}
