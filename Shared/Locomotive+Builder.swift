//
//  Locomotive+Builder.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Builds each space in the board

extension Locomotive {
    static func build() -> [Locomotive] {
        let locomotives: [Locomotive] = [
            // name,               cost, generation, capacity
            Locomotive("General I"        , 4, .green     , .first, 3),
            Locomotive("Fast Freight I"   , 8, .red       , .first,  3),
            Locomotive("Heavy I"          , 12, .yellow   , .first,  2),
            Locomotive("Special"          , 16, .blue     , .first,  1),
            Locomotive("General II"       , 20, .green    , .second,  4),
            Locomotive("Fast Freight II"  , 24, .red      , .second,  3),
            Locomotive("Heavy II"         , 28, .yellow   , .second,  3),
            Locomotive("General III"      , 32, .green    , .third,  4),
            Locomotive("Special"          , 36, .blue     , .second,  2),
            Locomotive("Fast Freight III" , 40, .red      , .third,  4),
            Locomotive("General IV"       , 44, .green    , .fourth,  5),
            Locomotive("Heavy III"        , 48, .yellow   , .third,  3),
            Locomotive("Fast Freight IV"  , 52, .red      , .fourth, 4),
            Locomotive("General IV"       , 56, .green    , .fifth,  5)
        ]
        return locomotives
    }
}
