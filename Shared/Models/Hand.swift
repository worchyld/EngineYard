//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum HandError: Error {
    case alreadyHaveCardFromThisDeck
    case cannotFind(card: Card)
    case handIsEmpty
    case handHasNoOwner
    case couldNotHandleCard(card: Card)
}

class Hand {
    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

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
    func push(card: Card) -> Error? {
        do {
            let result = try canPush(card: card)

            if (result) {
                self.didPush(card: card)
                return nil
            }
            else {
                return HandError.couldNotHandleCard(card: card)
            }
        } catch let error {
            return error
        }
    }

    //: Remove a card from a players hand
    func pop(card: Card) -> Error? {
        // #TODO
        return nil
    }
}

// Public static functions
extension Card {
    public static func find(card: Card, in cards:[Card]) -> Card? {
        guard let card = (cards.filter({
            return $0 == card
        }).first) else {
            return nil
        }
        return card
    }

    public static func findIndexOf(card: Card, in cards:[Card]) -> Int? {
        guard (cards.count > 0) else {
            return nil
        }

        guard let index = (cards.firstIndex { (c: Card) -> Bool in
            return (c == card)
        }) else {
            return nil
        }

        return index
    }
}

extension Hand {
    private func canPush(card: Card) throws -> Bool {
        guard let _ = self.owner else {
            throw HandError.handHasNoOwner
        }

        let results = self.cards.filter({
            return ($0.parent == card.parent)
        }).count

        guard (results == 0) else {
            throw HandError.alreadyHaveCardFromThisDeck
        }

        return true
    }

    private func canPop(card: Card) throws -> Bool {
        // #TODO
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

    private func didPop(card: Card) {
        // #TODO
        /*
        self.cards.removeAll { (c: Card) -> Bool in
            return (c == card)
        }*/
    }

}
