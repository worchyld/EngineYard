//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum HandError : Error {
    case handNotInitialized
    case handIsEmpty
    case alreadyHaveThisCard(_ card: Card)
    case notAvailable(_ card: Card)
    case cannotFind(_ card: Card)
}

class Hand {
    private (set) var cards: [Card]?

    init(_ cards: [Card]? = nil) {
        self.cards = cards
    }
}

extension Hand {
    func add(_ card: Card) throws {
        if (self.cards == nil) {
            self.cards = [Card]()
        }

        do {
            let ok = try canAdd(card)
            if ok {
                self.push(card)
            }
        } catch {
            throw error
        }
    }

    // #TODO -- Need to check that the card matches certain state
    //  & deck requirements

    internal func canAdd(_ card: Card) throws -> Bool {
        guard let cards = self.cards else {
            throw HandError.handNotInitialized
        }

        // Does the card already exist in player's hand?
        guard (!cards.contains(card)) else {
            throw HandError.alreadyHaveThisCard(card)
        }

        // Can only hold 1 of each family
        let family = card.family

        let filter = self.cards?.filter({ (c: Card) -> Bool in
            return (c.family == family)
        })

        guard (filter?.count == 0) else {
            throw HandError.alreadyHaveThisCard(card)
        }

        return true
    }

    private func push(_ card: Card) {
        self.cards?.append(card)
    }

}

extension Hand {
    func remove(_ card: Card) throws {
        do {
            let index = try canRemove(card)
            self.pop(card, at: index)
        } catch {
            throw error
        }
    }

    internal func canRemove(_ card: Card) throws -> Int {
        // check hand is not empty
        guard let cards = self.cards else {
            throw HandError.handNotInitialized
        }
        guard (!cards.isEmpty) else {
            throw HandError.handIsEmpty
        }

        // does card exist in hand
        guard (cards.contains(card)) else {
            throw HandError.cannotFind(card)
        }

        // try to find first index of the card in array
        guard let index = cards.firstIndex(of: card) else {
            throw HandError.cannotFind(card)
        }

        return index
    }

    private func pop(_ card: Card, at index: Int) {
        self.cards?.remove(at: index)
    }
}
