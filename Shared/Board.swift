//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Space?]

enum GameDataError : Error {
    case invalidGame
    case invalidData
    case couldNotLoadFile(_ filename: String)
    case couldNotSaveFile(_ filename: String)
}

class TrainGame {
    var board: Board?

    func start() throws {
        if let board = try TrainGame.loadInitialBoard() {
            self.board = board
        }
        else {
            throw GameDataError.invalidGame
        }
    }
}

extension TrainGame {
    static func loadInitialBoard() throws -> Board? {
        let board = [Space?](repeating: nil, count: 14)


        do {
            let bundle = Bundle.main
            guard let data = try DataLoader.loadData(using: bundle, filename: "board.json") else {
                throw GameDataError.invalidData
            }

            JSONParser.decodeJSON(from: data) { (response, error) in
                if let error = error {
                    print (error)
                }
                else {
                    print (response as Any)
                }
            }

        } catch {
            throw error
        }


        return board
    }
}
