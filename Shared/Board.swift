//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Space?]

class TrainGame {
    var board: Board?

    func start() throws {
        let board = TrainGame.loadInitialBoard()

        print ("board: \(board as Any)")
    }
}

extension TrainGame {
    static func loadInitialBoard() -> Board? {
        let board = [Space?](repeating: nil, count: 14)

        // 1. get response object from data in local json file

        // 2. prepare/build the board

        // 3. save to cloudkit/database?

        return board
    }
}
