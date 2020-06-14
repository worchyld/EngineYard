//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum HandError : Error, Equatable {
    case handNotInitialized
    case handIsEmpty
    case duplicateCardFound
    case notAvailable(_ card: Card)
    case cannotFind(_ card: Card)
    case alreadyHaveCardFromThisFamily(_ family: Family)
    case locomotiveHasNoCards
    case locomotiveIsOld
    case locomotiveIsObsolete
    case locomotiveIsNotAvailable
    case couldNotPush(_ card: Card)
    case couldNotPop(_ card: Card)
}

class Hand {
    private (set) var cards: [Card] = [Card]()
    public var size: Int {
        return self.cards.count
    }
    public var isEmpty: Bool {
        return self.cards.isEmpty
    }

    init(_ cards: [Card]? = nil) {
        guard let cards = cards else {
            return
        }
        self.cards = cards
    }
}

extension Hand {
    func add(_ card: Card) throws {
        do {
            if try canAdd(card) {
                self.push(card)
            }
            else {
                throw HandError.couldNotPush(card)
            }
        } catch {
            throw error
        }
    }

    // #TODO -- Need to check that the card matches certain state
    //  & deck requirements

    internal func canAdd(_ card: Card) throws -> Bool {
        if (cards.isEmpty) {
            return true
        }

        // Does the card already exist in player's hand?
        guard (!cards.contains(card)) else {
            throw HandError.duplicateCardFound
        }

        // Can only hold 1 of each family
        let family = card.family

        let filter = self.cards.filter({ (c: Card) -> Bool in
            return (c.family == family)
        })

        guard (filter.count == 0) else {
            throw HandError.alreadyHaveCardFromThisFamily(card.family)
        }

        return true
    }

    private func push(_ card: Card) {
        self.cards.append(card)
    }

}

extension Hand {
    func remove(_ card: Card) throws {
        do {
            guard let index = try canRemove(card) else {
                throw HandError.couldNotPop(card)
            }
            self.pop(card, at: index)

        } catch {
            throw error
        }
    }

    internal func canRemove(_ card: Card) throws -> Int? {
        // check hand is not empty
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
        self.cards.remove(at: index)
    }
}
