//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Production {

    func add(units: Int, card: Card) -> Card {
        card.units += units
        return card
    }

    func spend(units: Int, card: Card) -> Card {
        guard (canSpend(units: units, card: card)) else {
            return card
        }
        card.spentUnits += units
        card.units -= units
        return card
    }

    func reset(card: Card) -> Card {
        card.units += card.spentUnits
        card.spentUnits = 0
        return card
    }

    private func canSpend(units: Int, card: Card) -> Bool {
        return true
    }

}
