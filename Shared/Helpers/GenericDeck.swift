//
//  GenericDeck.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

protocol DeckDelegate: AnyObject {
    associatedtype Element
    var size: Int { get }
    var isEmpty: Bool { get }
    var cards:[Element] { get set }
    func push(_ element: Element)
    func pop() -> Element?
}

class GenericDeck<Element> : DeckDelegate, Identifiable {
    let id: UUID
    
    var size: Int {
        return cards.count
    }
    var isEmpty: Bool {
        return (cards.count == 0)
    }
    
    final internal var cards: [Element] = []
    
    init(id: UUID, cards: [Element]?) {
        self.id = id
        if let cards = cards {
            self.cards = cards
        } else {
            self.cards = [Element]()
        }
    }
    
    func push(_ element: Element) {
        cards.append(element)
    }
    
    func pop() -> Element? {
        cards.popLast()
    }
}

extension GenericDeck {
    var topItem: Element? {
        return cards.isEmpty ? nil : cards[cards.count - 1]
    }
}
