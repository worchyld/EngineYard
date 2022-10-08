//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

class Deck : Identifiable {
    private let uuid: UUID = UUID()
    public let loco: Locomotive
    public var cards: [Card] = [Card]()
    
    init(locomotive: Locomotive, cards: [Card]) {
        self.loco = locomotive
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
