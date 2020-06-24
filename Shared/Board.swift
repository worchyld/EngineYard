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
        let board = [Space?](repeating: nil, count: 14)


        // 1. get response object from data in local json file
        do {

            let api = FixturesLoaderAPI.shared

            guard let result = try api.loadJSON() else {
                throw BundleError.unknown("Did not find response from local file")
            }
            print ("RESULT -- \(result as Any)")

        }
        catch {
            throw error
        }

        // 2. prepare/build the board

        // 3. save to cloudkit/database?

        return board
    }


    


}


