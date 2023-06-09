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
    
    init(decks: Deck<Locomotive>) {
        self.decks = decks
    }
    
}

extension Board {

}
