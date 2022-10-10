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

final class GenericDeck<Element> : DeckDelegate {
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
    
    func pop() -> Element? {
        cards.popLast()
    }
}

extension GenericDeck {
    var topItem: Element? {
        return cards.isEmpty ? nil : cards[cards.count - 1]
    }
}
