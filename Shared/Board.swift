//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Factory?]

class TrainGame {
    var board: Board!

    func start() throws {
        do {
            let board = try loadInitialBoard()
            print ("board: \(board as Any)")
        }
        catch {
            throw error
        }
    }
}


extension TrainGame {
    func loadInitialBoard() throws -> Board? {
        var board = [Factory?](repeating: nil, count: 14)


        return board
    }

}

