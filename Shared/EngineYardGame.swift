//
//  EYGame.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of 14 'decks/spaces'.  Each space holds cards
typealias Board = [Deck?]

class EngineYardGame {
    var board: Board?
}

extension EngineYardGame {
    static func loadInitialBoard() -> Board? {
        let decks = Deck.build()
        let cards = Card.build()

        var board = [Deck?]([Deck?](repeating: nil, count:  14))

        // Walk through each position in the board
        // then add the cards to that array
        //
        //decks.forEach { (deck: Deck) in
        //    deck.cards = Card.filter(cards: cards, matching: (color: deck.color, generation: deck.generation))
        //}
        //board = decks

        for (index, deck) in decks.enumerated() {
            deck.cards = Card.filter(cards: cards, matching: (color: deck.color, generation: deck.generation))
            board[index] = deck
        }

        return board
    }
}
