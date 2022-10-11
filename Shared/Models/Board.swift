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
    func unlockNext() {
//        let lockedDecks = self.decks.filter { deck in
//            return deck.loco.rust < .rusted && deck.
//        }
    }
}
