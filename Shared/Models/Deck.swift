//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

// Locomotive decks

class Deck : GenericDeck<Card> {
    private var locomotive: Locomotive
    public var loco: Locomotive {
        return self.locomotive
    }
    
    init(loco: Locomotive) {
        self.locomotive = loco
        super.init(id: UUID(), cards: nil)
    }
}
