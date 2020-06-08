//
//  EYGame.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of 14 'spaces'.  Each space holds cards
typealias Board = [Deck?]

class EYGame { }

extension EYGame {
    static func loadInitialBoard() -> Board? {
        let decks = Deck.build()
        let cards = Card.build()

        // Fill each deck with the cards
        //   as defined by each deck
        var board: Board?

        

        return board
    }
}
