//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

// Locomotive decks

class Deck : GenericDeck<Card> {
    private let locomotive: Locomotive
    public var loco: Locomotive {
        return self.locomotive
    }
    
    init(loco: Locomotive, cards: [Card]? = nil) {
        self.locomotive = loco
        super.init(id: UUID(), cards: cards)
    }
}
