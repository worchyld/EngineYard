//
//  EYGame.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of 14 spaces.  Each space holds cards
typealias Board = [BoardSpace?]

class EYGame { }

extension EYGame {
    static func buildBoard() -> Board{
        let board: [BoardSpace] = [
            BoardSpace(0, .green     , .first, 3),
            BoardSpace(1, .red       , .first,  3),
            BoardSpace(2, .yellow    , .first,  2),
            BoardSpace(3, .blue      , .first,  1),
            BoardSpace(4, .green     , .second,  4),
            BoardSpace(5, .red       , .second,  3),
            BoardSpace(6, .yellow    , .second,  3),
            BoardSpace(7, .green     , .third,  4),
            BoardSpace(8, .blue      , .second,  2),
            BoardSpace(9, .red       , .third,  4),
            BoardSpace(10, .green    , .fourth,  5),
            BoardSpace(11, .yellow   , .third,  3),
            BoardSpace(12, .red      , .fourth, 4),
            BoardSpace(13, .green    , .fifth,  5)
        ]
        return board
    }
}


/*
extension EYGame {

    static func buildBoard() -> Board {
        var board = [BoardSpace?]([BoardSpace?](repeating: nil, count:  14))

        board[0] = BoardSpace.init(id: 0, cost: 4, color: .green, generation: .first, orderCapacity: 3)
//
//        let positions = [
//                   BoardPosition.init(0, color: .green, generation: .first, orderCapacity: 3),
//                   BoardPosition.init(1, color: .red, generation: .first, orderCapacity: 3),
//                   BoardPosition.init(2, color: .yellow, generation: .first, orderCapacity: 2),
//                   BoardPosition.init(3, color: .blue, generation: .first, orderCapacity: 1),
//                   BoardPosition.init(4, color: .green, generation: .second, orderCapacity: 4),
//                   BoardPosition.init(5, color: .red, generation: .second, orderCapacity: 3),
//                   BoardPosition.init(6, color: .yellow, generation: .second, orderCapacity: 3),
//                   BoardPosition.init(7, color: .green, generation: .third, orderCapacity: 4),
//                   BoardPosition.init(8, color: .blue, generation: .second, orderCapacity: 2),
//                   BoardPosition.init(9, color: .red, generation: .third, orderCapacity: 4),
//                   BoardPosition.init(10, color: .green, generation: .fourth, orderCapacity: 5),
//                   BoardPosition.init(11, color: .yellow, generation: .third, orderCapacity: 3),
//                   BoardPosition.init(12, color: .red, generation: .fourth, orderCapacity: 4),
//                   BoardPosition.init(13, color: .green, generation: .fifth, orderCapacity: 5)
//               ]


        return board
    }
}
*/
