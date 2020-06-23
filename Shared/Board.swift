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
        if let board = try TrainGame.loadInitialBoard() {
            self.board = board
        }
        else {
            print ("Error occurred")
        }
    }
}

extension TrainGame {
    static func loadInitialBoard() throws -> Board? {
        let board = [Space?](repeating: nil, count: 14)



        return board
    }
}
