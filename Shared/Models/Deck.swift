//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

typealias Deck = LocomotiveDeck

class LocomotiveDeck : Identifiable {
    private let uuid: UUID = UUID()
    private let _loco: Locomotive
    public var loco: Locomotive {
        return self._loco
    }
    
    public var cards: [Card] = [Card]()
    
    init(loco: Locomotive, cards: [Card]) {
        self._loco = loco
        self.cards = cards
    }
    
    public var isEmpty : Bool {
        return (self.cards.count == 0)
    }
}

extension Deck : Equatable {
    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}

extension Deck : CustomStringConvertible {
    var description: String {
        return ("Deck: { \(self.loco.livery) \(self.loco.generation) }")
    }
}
