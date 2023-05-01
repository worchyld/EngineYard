//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

enum CardError : Error {
    case cannotBeSameCard
    case cardIsNotActive(card: Card)
    case cardIsRusted(card: Card)
    case cardNotFound
    case deckIsEmpty
}

class Card: Identifiable, Equatable {
    internal let id: UUID
    private let loco: Locomotive
    var productionUnits: Int = 1
    var spentUnits: Int = 0
    
    init(id: UUID = UUID(), locomotive: Locomotive, productionUnits: Int, spentUnits: Int = 0) {
        self.id = id
        self.loco = locomotive
        self.productionUnits = productionUnits
        self.spentUnits = spentUnits
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension Card {
    func add(units: Int) throws {
        self.productionUnits += units
    }
    
    func spend(units: Int) throws {
        self.spentUnits += units
        self.productionUnits -= units
    }
    
    func reset() {
        self.productionUnits = self.spentUnits
        self.spentUnits = 0
    }
    
    func find(card: Card, in pile: [Card]) -> Card? {
        let result = pile.filter { c in
            return c.id == card.id
        }.first
        return result
    }
    
    func popCardFromDeck(_ deck: [Card], withUUID uuid: UUID) throws -> [Card] {
        guard !deck.isEmpty else {
            throw CardError.deckIsEmpty
        }
        guard let index = deck.firstIndex(where: { $0.id == uuid }) else {
            throw CardError.cardNotFound
        }
        var mutableDeck = deck
        mutableDeck.remove(at: index)
        return mutableDeck
    }
    
    func transfer(units: Int, from: Card, to: Card, deck: [Card]) throws {
        guard units.isPositive else {
            throw NumericError.mustBeGreaterThanZero
        }
        guard from.id != to.id else {
            throw CardError.cannotBeSameCard
        }
        guard from.loco.isActive else {
            throw CardError.cardIsNotActive(card: from)
        }
        guard to.loco.isActive else {
            throw CardError.cardIsNotActive(card: from)
        }
        guard from.loco.rust != .rusted else {
            throw CardError.cardIsRusted(card: to)
        }
        guard to.loco.rust != .rusted else {
            throw CardError.cardIsRusted(card: to)
        }
        
        guard let seekFromCard = find(card: from, in: deck) else {
            throw CardError.cardNotFound
        }
        guard let seekToCard = find(card: to, in: deck) else {
            throw CardError.cardNotFound
        }

        seekToCard.productionUnits += units
        seekFromCard.productionUnits -= units
        
        if (seekFromCard.productionUnits == 0) {
            do {
                let _ = try popCardFromDeck(deck, withUUID: seekFromCard.id)
            } catch let err {
                throw err
            }
        }
    }

}
