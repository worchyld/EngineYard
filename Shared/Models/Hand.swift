//
//  Hand.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


// Only responsible for pushing and popping cards
// to a collecion of cards with validation
class Hand {
    private var hand: [Card]

    init(cards: [Card]) {
        self.hand = cards
    }

    /// Push a card to a players hand
    func push(_ card: Card) throws -> [Card] {
        do {
            if try canPush(card) {
                didPush(card)
            }
            return self.hand
        }
        catch {
            throw error
        }
    }


    /// Pop a card from a players hand
    func pop(card: Card) throws -> [Card] {
        do {
            if try canPop(card) {
                if let index = try self.findIndexOf(card) {
                    didPop(card, at: index)
                }
            }
            return self.hand
        }
        catch {
            throw error
        }
    }
}

extension Hand {
    func canPush(_ card: Card) throws -> Bool {
        return true
    }

    func canPop(_ card: Card) throws -> Bool {        
        return true
    }

    internal func findIndexOf(_ card: Card) throws -> Int? {
        if let index = hand.firstIndex(where: { $0.id == card.id }) {
            return index
        }
        else {
            throw CardError(reason: .noCardsFound)
        }
    }
}

extension Hand {
    internal func didPop(_ card: Card, at index: Int) {
        self.hand.remove(at: index)
    }

    internal func didPush(_ card: Card) {
        self.hand.append( card )
    }
}
