//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Train?]

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
        let board = [Train?](repeating: nil, count: 14)

        let api = DataLoader.shared
        let result = api.load(from: Bundle.main, file: Constants.boardJSONFile)

        switch result {
        case .success(let response):
            print ("RESPONSE RETURNED >> \(response)")

        case .failure(let error):
            throw error
        }

        return board
    }

}
