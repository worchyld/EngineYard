//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 01/05/2023.
//

import Foundation

// Generic deck
class Deck<Element> {
    var size: Int {
        return cards.count
    }
    
    var isEmpty: Bool {
        return (cards.count == 0)
    }
    
    internal var cards: [Element] = []
    
    func push(_ element: Element) {
        cards.append(element)
    }
    
    func pop(_ card: Element) -> Element? where Element: Equatable {
        guard let index = find(card) else {
            return nil
        }
        return cards.remove(at: index)
    }
    
    func find(_ card: Element) -> Int? where Element: Equatable {
        cards.firstIndex(of: card)
    }
    
    func shuffle() {
        cards.shuffle()
    }    
}
