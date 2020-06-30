//
//  Hand.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class Hand {
    private var hand: [Card]

    init(cards: [Card]) {
        self.hand = cards
    }

    /// Push a card to a players hand
    func push(_ card: Card) throws -> [Card] {
        do {
            if try canPush(card) {

            }
            return self.hand
        }
        catch {
            throw error
        }
    }


    /// Pop a card from a players hand
    func pop(card: Card) throws -> [Card] {
        return self.hand
    }
}

extension Hand {
    func canPush(_ card: Card) throws -> Bool {
        return true
    }

    func canPop(_ card: Card) throws -> Bool {
        return true
    }

    func findIndexOf(_ card: Card) throws -> Int {
        return 0
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
