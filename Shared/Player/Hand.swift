//
//  Tableau.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

typealias Tableau = Hand

enum HandError: Error {
    case alreadyOwnThisTypeOfCard
    case cannotFindCard
}

class Hand : CustomStringConvertible {
    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

    init(owner: Player) {
        self.owner = owner
    }
}

extension Hand {
    var description: String {
        guard let ownership = self.owner else {
            return "No owner"
        }
        return ("Hand owner: \(ownership) - Cards: \(self.cards.count)")
    }
}

extension Hand {

    func add(card: Card) -> Bool {
        self.cards.append(card)
        return true
    }

    func remove(card: Card) -> Bool {
        
        return true
    }

    private func find(card: Card) -> Card? {
        return nil
    }
}


