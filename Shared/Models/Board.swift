//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2022.
//

import Foundation

// Board has a number of decks (14)
class Board {
    public private(set) var decks: [Deck] = [Deck]()
    
    init(_ decks: [Deck] = [Deck]()) {
        self.decks = decks
    }
}

extension Board {
    func prepare() {
        let locos = Locomotive.allLocos()
        
        for loco in locos {
            let deck: Deck = Deck(loco: loco)
            
            for _ in 1...loco.qty {
                let card = Card(id: UUID(), locomotive: loco)
                deck.push(card)
            }
            
            self.decks.append(deck)
        }
    }
}
