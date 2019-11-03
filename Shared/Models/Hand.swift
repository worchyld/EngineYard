//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

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
    func push(card: Card?) throws -> Error? {
        do {
            let cardObj = try canPush(card: card)
            self.didPush(card: cardObj)
        } catch let error {
            throw error
        }
        return nil
    }

    func pop(card: Card?) throws -> Error? {
        return nil
    }
}

extension Hand {

    internal func canPush(card: Card?) throws -> Card {
        guard let cardObj = card else {
            throw CardError.cardDoesNotExist
        }
        guard let deck = cardObj.parent else {
            throw CardError.cardHasNoParent
        }
        if (cardObj.owner != nil) {
            throw CardError.cardAlreadyHasOwner
        }
        guard self.alreadyHaveCardInHand(card: cardObj) else {
            throw CardError.cardAlreadyHasOwner
        }
        guard (self.alreadyHaveCardFrom(deck: deck) == false) else {
            throw CardError.alreadyHaveCardFromThisDeck
        }
        return cardObj
    }

    private func didPush(card: Card) {
        guard let owner = self.owner else {
            assertionFailure(CardError.handHasNoOwner.localizedDescription)
            return
        }
        card.setOwner(owner: owner)
        self.cards.append(card)
    }

    private func alreadyHaveCardFrom(deck: Deck) -> Bool {
        guard let owner = self.owner else {
            assertionFailure(CardError.handHasNoOwner.localizedDescription)
            return false
        }
        let results = (deck.cards.filter({ (card: Card) -> Bool in
            return ((card.parent == deck) && (card.owner == owner))
        }).count)

        guard (results == 0) else {
            return true
        }
        return false

    }

    private func alreadyHaveCardInHand(card: Card) -> Bool {
        let results = (self.cards.filter({
            return ($0.owner! == self.owner!)
        }).count)

        guard (results == 0) else {
            return false
        }
        return true
    }

    func contains(deck: Deck) -> Bool {
        // does my hand already contain a card from deck
        let filter1 = self.cards.contains(where: {
            return ($0.parent == deck)
        })
        if (filter1 == true) {
            return true
        }
        else {
            // is there any nil owner spaces available
            let results = deck.cards.filter({ (card) -> Bool in
                return (card.owner == nil)
            })
            return (results.count == 0)
        }
    }
}
