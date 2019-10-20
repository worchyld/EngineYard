//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum HandError: Error, Equatable {
    case alreadyHaveCardFromThisDeck
    case cannotFind(card: Card)
    case handIsEmpty
    case handHasNoOwner
    case couldNotHandleCard(card: Card)
}

class Hand {
    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()
    public var size: Int {
        return self.cards.count
    }

    init(owner: Player) {
        self.owner = owner
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}

extension Hand {
    //: Add card to a players hand

    func push(card: Card) throws -> Error? {
        do {
            let result = try canPush(card: card)
            if (result) {
                self.didPush(card: card)
                return nil
            }
        } catch let error {
            throw error
        }
        return nil
    }

    //: Remove a card from a players hand
    func remove(card: Card) -> Error? {
        // #TODO
        return nil
    }

    public static func containsParent(deck: Deck) -> Bool {
        let filter = deck.cards.contains(where: {
            return ($0.parent == deck)
        })
        return filter
    }
}

extension Hand {
    // Rules:
    // Can't add if its from same deck
    // Can't add duplicates
    // Parent and owner must exist
    internal func canPush(card: Card) throws -> Bool {
        guard let _ = self.owner else {
            print ("Hand error 1: \(String(describing: self.owner))")
            throw HandError.handHasNoOwner
        }
        guard card.owner == nil else {            
            throw CardError.cardAlreadyHasOwner
        }
        guard let deck = card.parent else {
            throw CardError.cardHasNoParent
        }
        guard (Hand.containsParent(deck: deck) == false) else {
            throw HandError.alreadyHaveCardFromThisDeck
        }
        guard (deck.cards.filter({
            return ($0.owner == self.owner)
        }).count == 0) else {
            throw HandError.alreadyHaveCardFromThisDeck
        }

        return true
    }

    private func didPush(card: Card) {
        guard let owner = self.owner else {
            assertionFailure(HandError.handHasNoOwner.localizedDescription)
            return
        }
        card.setOwner(owner: owner)
        self.cards.append(card)
    }

    internal func canPop(card: Card) throws -> Bool {
        // #TODO
        return true
    }

    private func didPop(card: Card) {
        // #TODO
        /*
        self.cards.removeAll { (c: Card) -> Bool in
            return (c == card)
        }*/
    }

}
