//
//  BoardSpace+Builder.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Builds each space in the board

extension BoardSpace {
    static func buildBoard() -> Board{
        let board: [BoardSpace] = [
            BoardSpace(4, .green     , .first, 3),
            BoardSpace(8, .red       , .first,  3),
            BoardSpace(12, .yellow   , .first,  2),
            BoardSpace(16, .blue     , .first,  1),
            BoardSpace(20, .green    , .second,  4),
            BoardSpace(24, .red      , .second,  3),
            BoardSpace(28, .yellow   , .second,  3),
            BoardSpace(32, .green    , .third,  4),
            BoardSpace(36, .blue     , .second,  2),
            BoardSpace(40, .red      , .third,  4),
            BoardSpace(44, .green    , .fourth,  5),
            BoardSpace(48, .yellow   , .third,  3),
            BoardSpace(52, .red      , .fourth, 4),
            BoardSpace(56, .green    , .fifth,  5)
        ]
        return board
    }
}
