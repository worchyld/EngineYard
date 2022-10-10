//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

// Locomotive decks

class Deck : GenericDeck<Card> {
    private let loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
        super.init(id: UUID(), cards: nil)
    }
}
