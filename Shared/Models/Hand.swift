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
        guard let parent = card.parent else {
            throw TrainError(reason: .missing)
        }
        guard parent.available else {
            throw TrainError(reason: .unavailable)
        }
        guard (parent.rust != .rusted) else {
            throw TrainError(reason: .rusted)
        }

        let filterMatchingFamily = hand.filter {
            return ($0.parent?.generation == card.parent?.generation)
        }.count

        guard (filterMatchingFamily == 0) else {
            throw CardError(reason: .sameFamily)
        }

        let filterMatchingCardId = hand.filter {
            return ($0.id == card.id)
        }.count

        guard (filterMatchingCardId == 0) else {
            throw CardError(reason: .alreadyOwnThisCard)
        }

        return true
    }

    func canPop(_ card: Card) throws -> Bool {
        guard (card.units == 0 && card.spent == 0) else {
            return false
        }

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
