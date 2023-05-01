//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 01/05/2023.
//

import Foundation

// Generic deck

protocol DeckDelegate: AnyObject {
    associatedtype Element
    var size: Int { get }
    var isEmpty: Bool { get }
    var cards:[Element] { get set }
    func push(_ element: Element)
    func pop(_ card: Card) -> Element?
    func find(_ card: Element) -> Int?// where Element: Equatable
    func shuffle()
}

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
    
    func find(_ card: Element) -> Int? where Element : Equatable {
        return cards.firstIndex(of: card)
    }
    
    func pop(_ card: Element) -> Element? where Element: Equatable {
        guard let index = find(card) else {
            return nil
        }
        return cards.remove(at: index)
    }
    
    func shuffle() {
        cards.shuffle()
    }    
}
