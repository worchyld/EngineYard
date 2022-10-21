//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2022.
//

import Foundation

class Board {
    private var _decks: [Deck]?
    public var decks: [Deck] {
        return self._decks ?? []
    }
    public var size: Int {
        return self.decks.count
    }
    
    init(decks: [Deck]? = nil) {
        self._decks = decks
    }
}

extension Board {
    func prepare() {
        let locos = Locomotive.allLocos()
        for loco in locos {
            let deck = Deck(loco: loco)
            for _ in 1...loco.qty {
                let card = Card(id: UUID(), locomotive: loco)
                deck.cards.append(card)
            }
        }
    }
}
