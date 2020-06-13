//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum HandError : Error {
    case handIsEmpty
    case alreadyHaveThisCard(_ card: Card)
    case notAvailable(_ card: Card)
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

    internal func canAdd(_ card: Card) throws -> Bool {
        return true
    }


    private func push(_ card: Card) {
        self.cards?.append(card)
    }

}

extension Hand {
    func remove(_ card: Card, at index: Int) throws {
        do {
            let ok = try canRemove(card, at: index)
            if ok {
                self.push(card)
            }
        } catch {
            throw error
        }
    }

    internal func canRemove(_ card: Card, at index: Int) throws -> Bool {
        return true
    }

    private func pop(_ card: Card, at index: Int) {

    }
}
