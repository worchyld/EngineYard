//
//  EYGame.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of 14 'spaces'.  Each space holds cards
typealias Board = [Locomotive?]

class EngineYardGame {
    var board: Board?
}

extension EngineYardGame {
    static func loadInitialBoard() -> Board? {
        let locomotives = Locomotive.build()
        let cards = Card.build()

        var board = [Locomotive?]([Locomotive?](repeating: nil, count:  14))

        // Walk through each position in the board
        // then add the cards to that locomotive

        for (index, loco) in locomotives.enumerated() {
            loco.cards = Card.filter(cards: cards, matching: (color: loco.color, generation: loco.generation))
            board[index] = loco
        }

        return board
    }
}
