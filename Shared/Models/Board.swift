//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2022.
//

import Foundation

class Board {
    //var decks : [Deck] = [Deck]()
}

/*
extension Board {
    func prepare() -> [Deck] {
        
        let cards = self.makeCards()
        
        let decks : [Deck] = [
            Deck(4, .green, .first, 3),
            Deck(8, .red, .first, 3),
            Deck(12, .yellow, .first, 2),
            Deck(16, .blue, .first, 1),
            Deck(20, .green, .second, 4),
            Deck(24, .red, .second, 3),
            Deck(28, .yellow, .second, 3),
            Deck(32, .green, .third, 4),
            Deck(36, .blue, .second, 2),
            Deck(40, .red, .third, 4),
            Deck(44, .green, .fourth, 4),
            Deck(48, .yellow, .third, 3),
            Deck(52, .red, .fourth, 4),
            Deck(56, .green, .fifth, 5),
        ]

        // Fill deck where the cost is the same
        let _ = decks.map {
            let deck = $0
            let cards = cards.filter {
                $0.cost == deck.cost
            }
            deck.cards.append(contentsOf: cards)
        }
        
        return decks
    }
    
    internal func makeCards() -> [Card] {
        var cards: [Card] = [Card]()
        
        for _ in 1...4 {
            let card = Card(4, .green, .first)
            cards.append(card)
        }
        
        for _ in 1...4 {
            let card = Card(20, .green, .second)
            cards.append(card)
        }
        
        for _ in 1...4 {
            let card = Card(32, .green, .third)
            cards.append(card)
        }
        
        for _ in 1...4 {
            let card = Card(44, .green, .fourth)
            cards.append(card)
        }
        
        for _ in 1...4 {
            let card = Card(56, .green, .fifth)
            cards.append(card)
        }            
        
        for _ in 1...3 {
            let card = Card(8, .red, .first)
            cards.append(card)
        }
        
        for _ in 1...3 {
            let card = Card(24, .red, .second)
            cards.append(card)
        }
        
        for _ in 1...3 {
            let card = Card(40, .red, .third)
            cards.append(card)
        }
        
        for _ in 1...4 {
            let card = Card(52, .red, .fourth)
            cards.append(card)
        }
        
        for _ in 1...2 {
            let card = Card(12, .yellow, .first)
            cards.append(card)
        }
        
        for _ in 1...2 {
            let card = Card(28, .yellow, .second)
            cards.append(card)
        }
        
        for _ in 1...3 {
            let card = Card(48, .yellow, .third)
            cards.append(card)
        }
        
        cards.append( Card(16, .blue, .first) )
        
        for _ in 1...2 {
            let card = Card(36, .blue, .second)
            cards.append(card)
        }

        return cards
    }
}
*/
