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
    
    init(with decks: [Deck] = [Deck]()) {
        self.decks = decks
    }
}

