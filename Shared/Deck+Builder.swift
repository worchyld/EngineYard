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
            // name,               cost, generation, capacity
            Deck("General I"        , 4, .green     , .first, 3),
            Deck("Fast Freight I"   , 8, .red       , .first,  3),
            Deck("Heavy I"          , 12, .yellow   , .first,  2),
            Deck("Special"          , 16, .blue     , .first,  1),
            Deck("General II"       , 20, .green    , .second,  4),
            Deck("Fast Freight II"  , 24, .red      , .second,  3),
            Deck("Heavy II"         , 28, .yellow   , .second,  3),
            Deck("General III"      , 32, .green    , .third,  4),
            Deck("Special"          , 36, .blue     , .second,  2),
            Deck("Fast Freight III" , 40, .red      , .third,  4),
            Deck("General IV"       , 44, .green    , .fourth,  5),
            Deck("Heavy III"        , 48, .yellow   , .third,  3),
            Deck("Fast Freight IV"  , 52, .red      , .fourth, 4),
            Deck("General IV"       , 56, .green    , .fifth,  5)
        ]
        return decks
    }
}
