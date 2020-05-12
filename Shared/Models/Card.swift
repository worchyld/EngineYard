//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class Card: Identifiable {
    let uuid: UUID = UUID()
    private (set) weak var owner: Player?
    private let deck: Deck
    var units: Int = 0
    var unitsSpent: Int = 0

    init(with deck: Deck) {
        self.deck = deck
    }
}

extension Card {
    func setOwner(_ owner: Player) {
        self.owner = owner
    }
}
