//
//  Deck+Builder.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Builds each space in the board

extension Deck {
    static func build() -> [Deck] {
        let decks: [Deck] = [
            // cost, name, generation, capacity
            Deck(4, .green     , .first, 3),
            Deck(8, .red       , .first,  3),
            Deck(12, .yellow   , .first,  2),
            Deck(16, .blue     , .first,  1),
            Deck(20, .green    , .second,  4),
            Deck(24, .red      , .second,  3),
            Deck(28, .yellow   , .second,  3),
            Deck(32, .green    , .third,  4),
            Deck(36, .blue     , .second,  2),
            Deck(40, .red      , .third,  4),
            Deck(44, .green    , .fourth,  5),
            Deck(48, .yellow   , .third,  3),
            Deck(52, .red      , .fourth, 4),
            Deck(56, .green    , .fifth,  5)
        ]
        return decks
    }
}
