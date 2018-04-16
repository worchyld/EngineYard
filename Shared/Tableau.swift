//
//  Tableau.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

typealias Hand = Tableau

enum TableauError: Error {
    case alreadyOwnThisTypeOfCard
    case cannotFindCard
}

class Tableau : NSObject {
    public private (set) weak var owner: Player?
    public private (set) var cards: [Card] = [Card]()

    init(owner: Player) {
        super.init()
        self.owner = owner
    }
}

extension Tableau {
    override var description: String {
        guard let ownership = self.owner else {
            return "No owner"
        }
        return ("Tableau owner: \(ownership) - Cards: \(self.cards.count)")
    }
}

extension Tableau {

    func add(card: Card) -> Bool {
        return true
    }

    func remove(card: Card) -> Bool {
        return true
    }

    private func find(card: Card) -> Card? {
        return nil
    }
}


