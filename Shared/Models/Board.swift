//
//  Board.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

final class Board {
    var players: [Player] = [Player]()
    var activePlayer: Player? = nil
    var activePlayerIndex: Int = 0
    
    var decks: Deck<Locomotive> = Deck<Locomotive>()
    
    init(decks: [Locomotive]) {
        self.decks = decks
    }
    
    func unlock(deck: Deck, index: IndexPath) {
        // TBD
    }
}

extension Board {

}
