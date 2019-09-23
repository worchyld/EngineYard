//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum HandError: Error, Equatable {
    case alreadyHaveCard
    case cannotFindCard
    case handIsEmpty
    case noOwnership
    case noParent
}


// Each player has their own hand of cards
class Hand {
    public private(set) weak var owner: Player?
    public private(set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
    }
}

extension Hand {
    // #TODO
    // push = add card to hand
    func push(card: Card) {

    }

    // #TODO
    func pop(card: Card) {

    }

    // #TODO
    private func canPush(card: Card) -> Bool {
        return true
    }

    // #TODO
    private func canPop(card: Card) -> Bool {
        return true
    }

    // #TODO
    private func find(card: Card) -> Card? {
        return nil
    }

    // #TODO
    private func find(card: Card) -> Int? {
        return nil
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}

extension HandError {
    static func == (lhs: HandError, rhs: HandError) -> Bool {
        switch (lhs, rhs) {
        case (.alreadyHaveCard, .alreadyHaveCard):
            return true
        case (.cannotFindCard, .cannotFindCard):
            return true
        case (.handIsEmpty, .handIsEmpty):
            return true
        case (.noOwnership, .noOwnership):
            return true
        case (.noParent, .noParent):
            return true
        default:
            return false
        }
    }
}
