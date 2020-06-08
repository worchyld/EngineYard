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

        var board: Board?

        // Walk through each position in the board then add the cards to that array
        //self.positions.mutateEach { (position) in
        //    position.cards = Board.get(cards: cards, whereColor: position.color, whereGeneration: position.generation)
        //}
        decks.forEach { (deck) in
            deck.cards = Card.filter(cards: cards, whereColor: deck.color, whereGeneration: deck.generation)
        }
        board = decks

        return board
    }
}
